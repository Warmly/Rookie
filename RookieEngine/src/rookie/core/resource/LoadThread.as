package rookie.core.resource
{
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;

	import com.utils.LZMA;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getTimer;

	use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class LoadThread
	{
		private var _curLoadingItem:LoadItem;
		private var _eventDispatcher:EventDispatcher;
		private var _loaderContext:LoaderContext;
		private var _urlRequest:URLRequest;
		private var _urlLoader:URLLoader;
		private var _loader:Loader;
		private var _isLoading:Boolean;
		private var _curBytesLoaded:Number;
		private var _curBytesTotal:Number;
		private var _startTime:Number;
		private var _byteArrQueue:Vector.<ByteArray> = new Vector.<ByteArray>();
		private var _isURLLoaderLoading:Boolean;

		public function LoadThread(eventDispatcher:EventDispatcher, loaderContext:LoaderContext):void
		{
			_eventDispatcher = eventDispatcher;
			_loaderContext = loaderContext;

			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.OPEN, onOpen);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlLoader.addEventListener(Event.COMPLETE, onLoadToByteArrComplete);

			_urlRequest = new URLRequest();

			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadToDomainComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadToDomainError);
		}

		private function onLoadToDomainError(event:IOErrorEvent):void
		{
			onError(event);
		}

		private function onLoadToDomainComplete(event:Event):void
		{
			_isURLLoaderLoading = false;
			if (_curLoadingItem.resType == ResType.SWF || _curLoadingItem.resType == ResType.PACK_SWF)
			{
			}
			else if (_curLoadingItem.resType == ResType.JPG)
			{
				RookieEntry.resManager.bmdData.insert(_curLoadingItem.url, Bitmap(_loader.content).bitmapData);
			}
			if (_byteArrQueue.length)
			{
				loadByteArrToDomain();
			}
			else
			{
				_isLoading = false;
				_isURLLoaderLoading = false;
				RookieEntry.loadManager.setItemLoadedToken(_curLoadingItem.url);
				_curLoadingItem.onLoaded();
				_eventDispatcher.dispatchEvent(new LoadThreadEvent(LoadThreadEvent.ITEM_LOADED));
			}
		}

		private function loadByteArrToDomain():void
		{
			if (!_isURLLoaderLoading)
			{
				var byteArr:ByteArray = _byteArrQueue.shift();
				if (byteArr)
				{
					_isURLLoaderLoading = true;
					if (byteArr[0] == 0x5a)
					{
						byteArr = LZMA.decodeSWF(byteArr);
					}
					_loader.loadBytes(byteArr, _loaderContext);
				}
			}
		}

		private function onLoadToByteArrComplete(event:Event):void
		{
			var byteArr:ByteArray = _urlLoader.data;
			if (_curLoadingItem.resType == ResType.SWF || _curLoadingItem.resType == ResType.JPG)
			{
				_byteArrQueue.push(byteArr);
				loadByteArrToDomain();
			}
			else if (_curLoadingItem.resType == ResType.PACK_SWF)
			{
			    byteArr.endian = Endian.LITTLE_ENDIAN;
				var flag:uint = byteArr.readUnsignedInt();
				var num:uint = byteArr.readUnsignedInt();
				for (var i:int = 0;i < num;i++)
				{
					byteArr.position += 64;
					var length:uint = byteArr.readUnsignedInt();
					var eachSwfByteArr:ByteArray = new ByteArray();
					byteArr.readBytes(eachSwfByteArr, 0, length);
					_byteArrQueue.push(eachSwfByteArr);
				}
				loadByteArrToDomain();
			}
			else if (_curLoadingItem.resType == ResType.MAP_DATA)
			{
				_isLoading = false;
				RookieEntry.loadManager.setItemLoadedToken(_curLoadingItem.url);
				var unPackedData:ByteArray = LZMA.decode(_urlLoader.data);
				RookieEntry.resManager.byteArrData.insert(_curLoadingItem.url, unPackedData);
				_curLoadingItem.onLoaded();
				_eventDispatcher.dispatchEvent(new LoadThreadEvent(LoadThreadEvent.ITEM_LOADED));
			}
			else if (_curLoadingItem.resType == ResType.SPK)
			{
				_isLoading = false;
				RookieEntry.loadManager.setItemLoadedToken(_curLoadingItem.url);
				RookieEntry.resManager.byteArrData.insert(_curLoadingItem.url, _urlLoader.data);
				_curLoadingItem.onLoaded();
				_eventDispatcher.dispatchEvent(new LoadThreadEvent(LoadThreadEvent.ITEM_LOADED));
			}
		}

		private function onProgress(event:ProgressEvent):void
		{
			_curBytesLoaded = event.bytesLoaded;
			_curBytesTotal = event.bytesTotal;
		}

		private function onError(event:IOErrorEvent):void
		{
			var e:LoadThreadEvent = new LoadThreadEvent(LoadThreadEvent.LOAD_ERROR);
			e.errorInfo = event.toString();
			_eventDispatcher.dispatchEvent(e);
		}

		private function onOpen(event:Event):void
		{
			_curBytesLoaded = 0;
			_curBytesTotal = 0;
			_startTime = getTimer();
		}

		Rookie function load(loadItem:LoadItem):void
		{
			_curLoadingItem = loadItem;
			_urlRequest.url = loadItem.resUrl.url;
			_urlLoader.load(_urlRequest);
			_isLoading = true;
		}

		Rookie function get isLoading():Boolean
		{
			return _isLoading;
		}
		
		Rookie function get curUrl():String
		{
			if(_isLoading && _curLoadingItem)
			{
				return _curLoadingItem.url;
			}
			return "";
		}
	}
}
