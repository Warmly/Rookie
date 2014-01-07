package core.scene
{
	import core.creature.ActProcess;
	import core.creature.MyselfCpu;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import global.ModelEntry;
	import global.MyselfModel;
	import tool.SanguoCoorTool;
	import tool.SanguoTimeTool;

	import global.SanguoEntry;
	import global.ManagerBase;
	import rookie.tool.log.log;

	/**
	 * @author Warmly
	 */
	public class SceneManager extends ManagerBase
	{
		private var _scene:SanguoScene;
		private var _mapModel:MapModel;
		private var _myself:MyselfCpu;
		private var _myselfModel:MyselfModel;

		public function SceneManager()
		{
			_scene = SanguoEntry.scene;
			_mapModel = ModelEntry.mapModel;
			_myself = SanguoEntry.scene.myself;
			_myselfModel = ModelEntry.myselfModel;
		}
		
		public function handleMouseDown(event:MouseEvent):void
		{	
			var targetSceneCellCoor:Point = SanguoCoorTool.cameraToCell(event.stageX, event.stageY);
			createMoveProcess(targetSceneCellCoor);
		}
		
		public function handleKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.W:
					_myself.synAction(ActionEnum.RUN_ON_HORSE, DirectionEnum.UP);
					break;
				case Keyboard.A:
					_myself.synAction(ActionEnum.RUN_ON_HORSE, DirectionEnum.LEFT);
					break;
				case Keyboard.S:
					_myself.synAction(ActionEnum.RUN_ON_HORSE, DirectionEnum.DOWN);
					break;
				case Keyboard.D:
					_myself.synAction(ActionEnum.RUN_ON_HORSE, DirectionEnum.RIGHT);
					break;
			}
		}
		
		public function createMoveProcess(targetCell:Point):void
		{
			var dir:int = DirectionEnum.getDirection(_myselfModel.cellX, _myselfModel.cellY, targetCell.x, targetCell.y);
			_myself.synAction(ActionEnum.RUN_ON_HORSE, dir);
			var startTime:int = SanguoTimeTool.getCurTime();
			var cellDis:int = SanguoCoorTool.calCellDictance(_myselfModel.cellX, _myselfModel.cellY, targetCell.x, targetCell.y);
			var cost:int = cellDis * _myselfModel.costPerCell;
			var endTime:int = startTime + cost;
			var startPoint:Point = new Point(_myselfModel.cellX, _myselfModel.cellY);
			var endPoint:Point = targetCell;
			var newActProcess:ActProcess = new ActProcess(ActionEnum.RUN_ON_HORSE, startTime, endTime, startPoint, endPoint);
			_myself.setNewActProcess(newActProcess);
		}
	}
}
