package rookie.core.resource
{
	import rookie.tool.log.error;
	import rookie.dataStruct.HashTable;
	import rookie.namespace.Rookie;
	import rookie.tool.functionHandler.FunHandler;
	import rookie.tool.objectPool.ObjectPool;

	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;

	use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class LoadManager
	{
		private static const MAX_LOAD_THREAD_NUM:int = 2;
		private var _loadThreadQueue:Vector.<LoadThread>;
		private var _waitToLoadQueue:Vector.<Vector.<LoadItem>>;
		private var _eventDispatcher:EventDispatcher;
		private var _loaderContext:LoaderContext;
		// 加载过的资源的标记字典
		private var _loadedItemDic:HashTable = new HashTable(String, Boolean);

		public function LoadManager()
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
			if (!resUrl.url)
			{
				return;
			}
			if (isResAlreadyLoading(resUrl.url))
			{
				return;
			}
			if (_loadedItemDic.has(resUrl.url))
			{
				if (callBack)
				{
					callBack.execute();
				}
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
			_loadedItemDic.insert(url, true);
		}

		private function isResAlreadyLoading(url:String):Boolean
		{
			for each (var i : LoadThread in _loadThreadQueue)
			{
				if (i.curUrl && i.curUrl == url)
				{
					return true;
				}
			}
			return false;
		}

		private function isItemLoaded(loadItem:LoadItem):Boolean
		{
			return _loadedItemDic.has(loadItem.url);
		}

		private function onItemLoaded(event:LoadThreadEvent):void
		{
			loadLoop();
		}

		private function onLoadError(event:LoadThreadEvent):void
		{
			error(event.errorInfo);
			loadLoop();
		}
	}
}
