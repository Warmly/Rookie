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
	import rookie.algorithm.pathFinding.aStar.AStar;
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
		private var _pathFind:AStar;

		public function SceneManager()
		{
			_scene = SanguoEntry.scene;
			_mapModel = ModelEntry.mapModel;
			_myself = SanguoEntry.scene.myself;
			_myself.initActProcess();
			_myselfModel = ModelEntry.myselfModel;
			_pathFind = new AStar();
		}
		
		public function onMapLoaded():void
		{
			var vo:MapVO = _mapModel.curMapVO;
			var w:int = vo.numCellW + MapModel.MAP_W_ADD_CELL;
			var h:int = vo.numCellH + MapModel.MAP_H_ADD_CELL;
			var numCell:int = w * h;
			var arr:Array = [];
			for (var i:int = 0; i < numCell; i++)
			{
				arr.push(i);
			}
			_pathFind.parseArrToMap(arr, w, h);
		}
		
		public function handleMouseDown(event:MouseEvent):void
		{	
			var targetSceneCellCoor:Point = SanguoCoorTool.cameraToCell(event.stageX, event.stageY);
			//createMoveProcess(targetSceneCellCoor);
		}
		
		public function handleKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.W:
					_myself.synAction(ActionEnum.RUN, DirectionEnum.UP);
					break;
				case Keyboard.A:
					_myself.synAction(ActionEnum.RUN, DirectionEnum.LEFT);
					break;
				case Keyboard.S:
					_myself.synAction(ActionEnum.RUN, DirectionEnum.DOWN);
					break;
				case Keyboard.D:
					_myself.synAction(ActionEnum.RUN, DirectionEnum.RIGHT);
					break;
			}
		}
		
		public function createMoveProcess(targetCell:Point):void
		{
			//当前寻路未走完时，要走完这一格，再从这一格开始计算寻路
			var ap:ActProcess = _myself.actProcess;
			if (ap.isFinish)
			{
				_pathFind.init(_myselfModel.cellX, _myselfModel.cellY, targetCell.x, targetCell.y);
			}
			else
			{
				_pathFind.init(ap.curTgtPos.x, ap.curTgtPos.y, targetCell.x, targetCell.y);
			}
			if (_pathFind.findPath())
			{
				if (ap.isFinish)
				{
					_myself.actProcess.reset(ActionEnum.RUN, _pathFind.path, _myselfModel.costPerCell, new Point(_myselfModel.cellX, _myselfModel.cellY));
					_myself.actProcess.nextStep();
				}
				else
				{
					_myself.actProcess.reset(ActionEnum.RUN, _pathFind.path, _myselfModel.costPerCell);
				}
			}
		}
	}
}
