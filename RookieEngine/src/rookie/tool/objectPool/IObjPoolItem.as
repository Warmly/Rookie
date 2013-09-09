package rookie.tool.objectPool
{
	/**
	 * @author Warmly
	 */
	public interface IObjPoolItem
	{
		/**
		 * 从对象池中取出后，会自动调用 
		 */
		function reset() : void;

		/**
		 * 释放到对象池里 
		 */
		function dispose() : void;
	}
}
