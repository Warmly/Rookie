package core.scene.gpu
{
	import rookie.core.render.gpu.ImgGpu;
	import rookie.core.resource.ResUrl;
	/**
	 * ...
	 * @author Warmly
	 */
	public class SceneObjGpuBase extends ImgGpu
	{
		private var _depth:int;
		
		public function SceneObjGpuBase(resUrl:ResUrl)
		{
			super(resUrl);
		}
		
		public function get depth():int 
		{
			return _depth;
		}
		
		public function set depth(value:int):void 
		{
			_depth = value;
		}
	}
}