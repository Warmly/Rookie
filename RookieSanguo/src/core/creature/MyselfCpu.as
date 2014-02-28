package core.creature 
{
	import definition.ActionEnum;
	import flash.geom.Point;
	import global.ModelEntry;
	import global.MyselfModel;
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
			if (_actProcess && !_actProcess.isFinish)
			{
				synScenePixelPos(_actProcess.getCurPixelPos());
				synDirection(_actProcess.getCurDirection());
				trace(this.direction);
				_actProcess.checkStepFinish(this.x, this.y);
				if (_actProcess.isFinish)
				{
					synAction(ActionEnum.STAND);
					var logicPos:Point = SanguoCoorTool.sceneToCell(this.x, this.y)
					_myselfModel.cellX = logicPos.x;
					_myselfModel.cellY = logicPos.y;
				}
			}
		}
	}
}