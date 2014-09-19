package rookie.tool.objectPool 
{
	/**
	 * Base class of an object pool item
	 * @author Warmly
	 */
	public class ObjPoolItem implements IObjPoolItem 
	{
		protected var _disposed:Boolean = false;
		
		public function ObjPoolItem() 
		{
		}
		
		public function reset():void
		{
			_disposed = false;
		}
		
		public function dispose():void
		{
			_disposed = true;
			ObjectPool.addToPool(this);
		}
		
		public function get disposed():Boolean 
		{
			return _disposed;
		}
	}
}