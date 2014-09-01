package core.creature.cpu 
{
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
		public function MyselfCpu() 
		{
		}
		
		override public function render():void
		{
			super.render();
			if (_actProcess)
			{
				if(!_actProcess.isFinish)
				{
					var realTimePos:Point = _actProcess.getCurPixelPos();
					synPixelPos(realTimePos.x, realTimePos.y);
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
	}
}