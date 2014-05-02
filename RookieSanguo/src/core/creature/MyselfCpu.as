package core.creature 
{
	import definition.ActionEnum;
	import flash.geom.Point;
	import global.ModelEntry;
	import global.MyselfModel;
	import rookie.tool.log.log;
	import tool.SanguoCoorTool;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MyselfCpu extends UserCpu 
	{
		private var _myselfModel:MyselfModel;
		
		public function MyselfCpu() 
		{
			_myselfModel = ModelEntry.myselfModel;
		}
		
		public function refresh():void
		{
			if (_actProcess)
			{
				if(!_actProcess.isFinish)
				{
					var realTimePos:Point = _actProcess.getCurPixelPos();
					synScenePixelPos(realTimePos);
					var realTimeDir:int = _actProcess.getCurDirection();
					synAction(ActionEnum.RUN, realTimeDir);
					if (_actProcess.checkStepFinish())
					{
						var logicPos:Point = SanguoCoorTool.sceneToCell(this.x, this.y)
						_myselfModel.cellX = logicPos.x;
						_myselfModel.cellY = logicPos.y;
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