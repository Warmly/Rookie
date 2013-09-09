package rookie.core.resource
{
	import rookie.tool.functionHandler.FunHandler;
	import rookie.tool.objectPool.IObjPoolItem;

	/**
	 * @author Warmly
	 */
	public class LoadItem implements IObjPoolItem
	{
		private var _resUrl:ResUrl;
		private var _resType:int;
		private var _priority:int;
		private var _callBack:FunHandler;

		public function init(resUrl:ResUrl, resType:int, priority:int = 0, callBack:FunHandler = null):void
		{
			_resUrl = resUrl;
			_resType = resType;
			_priority = priority;
			_callBack = callBack;
		}

		public function onLoaded():void
		{
			if (_callBack)
			{
				_callBack.execute();
			}
		}

		public function reset():void
		{
		}

		public function dispose():void
		{
		}

		public function get url():String
		{
			return _resUrl.url;
		}

		public function get resUrl():ResUrl
		{
			return _resUrl;
		}

		public function get priority():int
		{
			return _priority;
		}

		public function get resType():int
		{
			return _resType;
		}
	}
}
