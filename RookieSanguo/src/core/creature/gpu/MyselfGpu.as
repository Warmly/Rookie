package core.creature.gpu 
{
	import core.scene.SanguoCamera;
	import global.SanguoEntry;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MyselfGpu extends UserGpu 
	{
		private var _camera:SanguoCamera;
		
		public function MyselfGpu() 
		{
			_camera = SanguoEntry.camera;
		}
		
		override public function render():void
		{
			super.render();
			synCamera();
		}
		
		private function synCamera():void
		{
			_camera.moveFocus(this.x, this.y);
		}
	}
}