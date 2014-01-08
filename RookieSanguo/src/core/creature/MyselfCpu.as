package core.creature 
{
	import definition.ActionEnum;
	import flash.geom.Point;
	import global.ModelEntry;
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
		
		public function refresh():void
		{
			var cellCoor:Point = SanguoCoorTool.sceneToCell(this.x, this.y);
			ModelEntry.myselfModel.cellX = cellCoor.x;
			ModelEntry.myselfModel.cellY = cellCoor.y;
			
			if (_actProcess)
			{
				if (_actProcess.isFinish)
				{
					_actProcess = null;
					synAction(ActionEnum.STAND);
				}
				else
				{
					refreshPosition();
				}
			}
		}
		
		public function refreshPosition():void
		{
			if (_actProcess)
			{
				setScenePixelPos(_actProcess.getCurPixelPos());
			}
		}
	}
}