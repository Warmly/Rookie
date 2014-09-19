package core.scene.cpu 
{
	import core.scene.ISceneObj;
	import rookie.core.render.cpu.AnimCpuBase;
	import rookie.core.resource.ResUrl;
	import rookie.definition.RenderEnum;
	import rookie.tool.namer.namer;
	
	/**
	 * Animation played in the scene based on CPU rendering
	 * @author Warmly
	 */
	public class SceneAnimCpu extends AnimCpuBase implements ISceneObj
	{
		private var _depth:uint;
		private var _id:Number;
		
		public function SceneAnimCpu(resUrl:ResUrl = null, play:int = 0) 
		{
			super(resUrl, play);
		}
		
		public function get depth():uint 
		{
			return _depth;
		}
		
		public function set depth(value:uint):void 
		{
			_depth = value;
		}
		
		public function get id():Number 
		{
			return _id;
		}
		
		public function set id(value:Number):void 
		{
			_id = value;
		}
	}
}