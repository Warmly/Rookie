package rookie.tool.objectPool
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Dictionary;

	/**
	 * @author Warmly
	 */
	public class ObjectPool
	{
		private static const MAX_COUNT : uint = 100;
		private static var _pools : Dictionary = new Dictionary();

		public static function getObject(cls : Class) : IObjPoolItem
		{
			var pool : Array = getPool(cls);
			var obj : IObjPoolItem;
			if (pool.length > 0)
			{
				obj = pool.pop();
			}
			else
			{
				obj = new cls();
			}
			obj.reset();
			return obj;
		}

		/**
		 * 在IObjPoolItem的dispose方法中调用
		 */
		public function addToPool(obj : IObjPoolItem) : void
		{
			var clsName : String = getQualifiedClassName(obj);
			var cls : Class = getDefinitionByName(clsName) as Class;
			var pool : Array = getPool(cls);
			if (pool.length < ObjectPool.MAX_COUNT)
			{
				if (pool.indexOf(obj) == -1)
				{
					pool.push(obj);
				}
			}
		}

		private static function getPool(cls : Class) : Array
		{
			if (cls in _pools)
			{
				return _pools[cls];
			}
			else
			{
				return _pools[cls] = [];
			}
		}
	}
}
