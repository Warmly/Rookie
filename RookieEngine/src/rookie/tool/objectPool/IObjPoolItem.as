package rookie.tool.objectPool
{
	/**
	 * Interface of an object pool item
	 * @author Warmly
	 */
	public interface IObjPoolItem
	{
		/**
		 * Automatically execute when getting out of pool
		 */
		function reset() : void;

		/**
		 * Dispose to pool
		 */
		function dispose() : void;
		
		/**
		 * Whether disposed
		 */
		function get disposed():Boolean; 
	}
}
