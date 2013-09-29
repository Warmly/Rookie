package rookie.core.render
{
	/**
	 * @author Warmly
	 */
	public interface IRenderItem
	{
		function render():void

		function dispose():void

		function get key():String
	}
}
