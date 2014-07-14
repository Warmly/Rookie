package core.scene 
{
	
	/**
	 * 场景中的物体
	 * @author Warmly
	 */
	public interface ISceneObj 
	{
		function set depth(value:uint):void
		
		function get depth():uint
		
		function get x():Number
		
		function get y():Number
		
		//function set id(value:Number):void
		
		function get id():Number
	}
}