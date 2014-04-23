package core.scene.gpu
{
	/**
	 * ...
	 * @author Warmly
	 */
	public class SceneObjGpuBase
	{
		private var _x:Number;
		private var _y:Number;
		private var _depth:int;
		
		public function SceneObjGpuBase()
		{
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
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