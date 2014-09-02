package core.creature.gpu 
{
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
		public function MyselfGpu() 
		{
		}
		
		override public function render():void
		{
			if (_actProcess)
			{
				if (!_actProcess.isFinish)
				{
					var realTimePos:Point = _actProcess.getCurPixelPos();
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
			super.render();
		}
	}
}