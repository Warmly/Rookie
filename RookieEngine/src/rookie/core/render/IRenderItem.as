package rookie.core.render
{
	/**
	 * @author Warmly
	 */
	public interface IRenderItem
	{
		function render():void

		function get key():String
		
		function get renderType():int
	}
}
