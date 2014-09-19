package core.scene.gpu 
{
	import core.scene.ISceneObj;
	import rookie.core.render.gpu.AnimGpuBase;
	import rookie.core.resource.ResUrl;
	import rookie.tool.objectPool.ObjectPool;
	
	/**
	 * Animation played in the scene based on GPU rendering
	 * @author Warmly
	 */
	public class SceneAnimGpu extends AnimGpuBase implements ISceneObj 
	{
		private var _depth:uint;
		private var _id:Number;
		
		public function SceneAnimGpu(resUrl:ResUrl = null, play:int = 0) 
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