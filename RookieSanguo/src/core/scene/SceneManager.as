package core.scene
{
	import core.creature.ActProcess;
	import core.creature.cpu.MyselfCpu;
	import core.creature.cpu.UserCpu;
	import core.creature.gpu.UserGpu;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import global.ModelEntry;
	import global.MyselfVO;
	import rookie.algorithm.pathFinding.NodeEnum;
	import rookie.algorithm.pathFinding.PathFinding;
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
		private var _myself:*;
		private var _myselfVO:MyselfVO;
		private var _pathFinding:PathFinding;

		public function SceneManager()
		{
			_scene = SanguoEntry.scene;
			_mapModel = ModelEntry.mapModel;
			_myself = SanguoEntry.scene.myself;
			_myselfVO = SanguoEntry.myselfVO;
			_pathFinding = new PathFinding();
		}
		
		public function onMapLoaded():void
		{
			var vo:MapVO = _mapModel.curMapVO;
			var numCellW:int = vo.numCellW;
			var numCellH:int = vo.numCellH;
			var arr:Array = [];
			for (var j:int = 0; j < numCellH; j++)
			{
				for (var i:int = 0; i < numCellW; i++) 
				{
					var type:int = NodeEnum.NORMAL;
					if (vo.getCellType(i, j))
					{
						type = vo.getCellType(i, j);
					}
					arr.push(type);
				}
			}
			_pathFinding.init(arr, numCellW, numCellH);
		}
		
		public function handleMouseDown(event:MouseEvent):void
		{	
			var targetSceneCellCoor:Point = SanguoCoorTool.cameraToCell(event.stageX, event.stageY);
			createMoveProcess(targetSceneCellCoor);
		}
		
		public function createMoveProcess(targetCell:Point):void
		{
			_myself.initActProcess();
			//当前寻路未走完时，要走完这一格，再从这一格开始计算寻路
			var ap:ActProcess = _myself.actProcess;
			if (ap.isFinish)
			{
				if (_pathFinding.findPath(_myselfVO.cellX, _myselfVO.cellY, targetCell.x, targetCell.y))
				{
					_myself.actProcess.reset(ActionEnum.RUN, _pathFinding.path, _myselfVO.costPerCell, new Point(_myselfVO.cellX, _myselfVO.cellY));
				}
			}
			else
			{
				if (_pathFinding.findPath(ap.curTgtPos.x, ap.curTgtPos.y, targetCell.x, targetCell.y))
				{
					_myself.actProcess.reset(ActionEnum.RUN, _pathFinding.path, _myselfVO.costPerCell);
				}
			}
		}
		
		public function addUserCpu(user:UserCpu):void
		{
			_scene.itemLayerCpu.addUser(user);
		}
		
		public function addUserGpu(user:UserGpu):void
		{
			_scene.itemLayerGpu.addUser(user);
		}
	}
}
