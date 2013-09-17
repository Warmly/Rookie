package rookie.core.resource
{
	import rookie.namespace.Rookie;
	import rookie.tool.functionHandler.FunHandler;
	import rookie.tool.objectPool.ObjectPool;

	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class ResManager
	{
		private static const MAX_LOAD_THREAD_NUM:int = 2;
		private var _loadThreadQueue:Vector.<LoadThread>;
		private var _waitToLoadQueue:Vector.<Vector.<LoadItem>>;
		private var _eventDispatcher:EventDispatcher;
		private var _loaderContext:LoaderContext;
		// 加载过的资源的标记字典
		private var _loadedItemDic:Dictionary = new Dictionary();
		// 二进制数据的字典
		private var _byteArrDataDic:Dictionary = new Dictionary();
		// 位图数据的字典
		private var _bmdDataDic:Dictionary = new Dictionary();

		public function ResManager()
		{
			_eventDispatcher = new EventDispatcher();
			_loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			_eventDispatcher.addEventListener(LoadThreadEvent.ITEM_LOADED, onItemLoaded);
			_eventDispatcher.addEventListener(LoadThreadEvent.LOAD_ERROR, onLoadError);
			initLoadThread();
			initLoadQueue();
		}

		public function load(resUrl:ResUrl, resType:int, priority:int = 0, callBack:FunHandler = null):void
		{
			if (resUrl.url && _loadedItemDic[resUrl.url] == true && callBack)
			{
				callBack.execute();
				return;
			}
			var loadItem:LoadItem = ObjectPool.getObject(LoadItem) as LoadItem;
			loadItem.init(resUrl, resType, priority, callBack);
			addToWaitToLoadQueue(loadItem);
			loadLoop();
		}

		private function addToWaitToLoadQueue(item:LoadItem):void
		{
			_waitToLoadQueue[item.priority].push(item);
		}

		private function loadLoop():void
		{
			for (var i:int = 0;i < MAX_LOAD_THREAD_NUM;i++)
			{
				loadThread(_loadThreadQueue[i]);
			}
		}

		private function loadThread(loadThread:LoadThread):void
		{
			if (!loadThread.isLoading)
			{
				var loadItem:LoadItem;
				var maxPriority:int = LoadPriority.HIGH;
				for (var i:int = maxPriority;i >= 0;i--)
				{
					var subQueue:Vector.<LoadItem> = _waitToLoadQueue[i];
					if (subQueue.length)
					{
						loadItem = subQueue.shift();
						break;
					}
				}
				if (loadItem)
				{
					if (isItemLoaded(loadItem))
					{
						loadItem.onLoaded();
						loadLoop();
					}
					else
					{
						loadThread.load(loadItem);
					}
				}
			}
		}

		private function initLoadThread():void
		{
			_loadThreadQueue = new Vector.<LoadThread>(MAX_LOAD_THREAD_NUM);
			for (var i:int = 0; i < MAX_LOAD_THREAD_NUM;i++)
			{
				_loadThreadQueue[i] = new LoadThread(_eventDispatcher, _loaderContext);
			}
		}

		private function initLoadQueue():void
		{
			_waitToLoadQueue = new Vector.<Vector.<LoadItem>>();
			var num:int = LoadPriority.HIGH;
			for (var i:int = 0; i <= num;i++)
			{
				_waitToLoadQueue[i] = new Vector.<LoadItem>();
			}
		}

		Rookie function setLoadedDicToken(url:String):void
		{
			_loadedItemDic[url] = true;
		}

		Rookie function setByteArrData(url:String, byteArr:ByteArray):void
		{
			_byteArrDataDic[url] = byteArr;
		}

		Rookie function setBmdData(url:String, bmd:BitmapData):void
		{
			_bmdDataDic[url] = bmd;
		}

		private function isItemLoaded(loadItem:LoadItem):Boolean
		{
			return _loadedItemDic[loadItem.url] == true;
		}

		private function onItemLoaded(event:LoadThreadEvent):void
		{
			loadLoop();
		}

		private function onLoadError(event:LoadThreadEvent):void
		{
			loadLoop();
		}
	}
}
