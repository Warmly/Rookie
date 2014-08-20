package core.creature.gpu 
{
	import core.scene.SanguoCamera;
	import definition.ActionEnum;
	import flash.geom.Point;
	import global.SanguoEntry;
	import tool.SanguoCoorTool;
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
			if (_actProcess)
			{
				if (!_actProcess.isFinish)
				{
					var realTimePos:Point = _actProcess.getCurPixelPos();
					synCamera(realTimePos);
					synPixelPos(realTimePos.x, realTimePos.y);
					var realTimeDir:int = _actProcess.getCurDirection();
					synAction(ActionEnum.RUN, realTimeDir);
					if (_actProcess.checkStepFinish())
					{
						var logicPos:Point = SanguoCoorTool.sceneToCell(this.x, this.y);
						synCellPos(logicPos.x, logicPos.y);
						synDepthByCurCellPos();
					}
				}
				else
				{
					synAction(ActionEnum.STAND);
					clearActProcess();
				}
			}
		}
		
		private function synCamera(focus:Point):void
		{
			_camera.moveFocus(focus.x, focus.y);
		}
	}
}