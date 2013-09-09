package rookie.core.resource
{
	import flash.display.Bitmap;

	import rookie.global.RookieEntry;

	import flash.net.URLRequest;

	import rookie.namespace.Rookie;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.system.LoaderContext;
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

		public function LoadThread(eventDispatcher:EventDispatcher, loaderContext:LoaderContext):void
		{
			_eventDispatcher = eventDispatcher;
			_loaderContext = loaderContext;

			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.OPEN, onOpen);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlLoader.addEventListener(Event.COMPLETE, onComplete);

			_urlRequest = new URLRequest();

			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadToDomainComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadToDomainError);
		}

		private function onLoadToDomainError(event:IOErrorEvent):void
		{
		}

		private function onLoadToDomainComplete(event:Event):void
		{
			if (_curLoadingItem.resType == ResType.SWF)
			{
			}
			else if (_curLoadingItem.resType == ResType.JPG)
			{
				RookieEntry.resManager.setBmdData(_curLoadingItem.url, Bitmap(_loader.content).bitmapData);
			}
			_isLoading = false;
			RookieEntry.resManager.setLoadedDicToken(_curLoadingItem.url);
			_curLoadingItem.onLoaded();
			_eventDispatcher.dispatchEvent(new LoadThreadEvent(LoadThreadEvent.ITEM_LOADED));
		}

		private function onComplete(event:Event):void
		{
			if (_curLoadingItem.resType == ResType.SWF || _curLoadingItem.resType == ResType.JPG)
			{
				_loader.loadBytes(_urlLoader.data, _loaderContext);
			}
			else if (_curLoadingItem.resType == ResType.DATA)
			{
				_isLoading = false;
				RookieEntry.resManager.setLoadedDicToken(_curLoadingItem.url);
				RookieEntry.resManager.setByteArrData(_curLoadingItem.url, _urlLoader.data);
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
			_eventDispatcher.dispatchEvent(new LoadThreadEvent(LoadThreadEvent.LOAD_ERROR));
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
	}
}
