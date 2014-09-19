package rookie.core.render.cpu
{
	import flash.display.DisplayObjectContainer;

	/**
	 * 适用于频繁addChild removeChild的cpu显示对象
	 * @author Warmly
	 */
	public interface IParent
	{
		function set parent(parent:DisplayObjectContainer):void

		function deleteParent():void
		
		function get parent():DisplayObjectContainer
	}
}
