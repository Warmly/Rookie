package core.creature.cpu 
{
	import core.scene.SanguoCamera;
	import definition.ActionEnum;
	import flash.geom.Point;
	import global.ModelEntry;
	import global.SanguoEntry;
	import rookie.tool.log.log;
	import tool.SanguoCoorTool;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MyselfCpu extends UserCpu 
	{
		private var _camera:SanguoCamera;
		
		public function MyselfCpu() 
		{
			_camera = SanguoEntry.camera;
		}
		
		override public function render():void
		{
			super.render();
			if (_actProcess)
			{
				if(!_actProcess.isFinish)
				{
					var realTimePos:Point = _actProcess.getCurPixelPos();
					trace(realTimePos);
					synPixelPos(realTimePos.x, realTimePos.y);
					synCamera();
					var realTimeDir:int = _actProcess.getCurDirection();
					synAction(ActionEnum.RUN, realTimeDir);
					if (_actProcess.checkStepFinish())
					{
						var logicPos:Point = SanguoCoorTool.sceneToCell(this.x, this.y)
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
		
		private function synCamera():void
		{
			_camera.moveFocus(this.x, this.y);
		}
	}
}