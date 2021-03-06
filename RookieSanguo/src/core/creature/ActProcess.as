package core.creature 
{
	import core.scene.MapModel;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import flash.geom.Point;
	import rookie.algorithm.pathFinding.aStar.AStarNode;
	import tool.CoorTool;
	import tool.TimeTool;
	import rookie.tool.log.log;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ActProcess 
	{
		private var _actionType:int;
		private var _path:Vector.<AStarNode> = new Vector.<AStarNode>();
		private var _curStartPos:Point;
		private var _curStartPixelPos:Point;
		private var _curTgtPos:Point;
		private var _curTgtPixelPos:Point;
		private var _curStartTime:int;
		private var _isFinish:Boolean;
		private var _costPerCell:Number;
		
		public function ActProcess() 
		{
			_isFinish = true;
		}
		
		/**
		 * 重置动作过程
		 * @param action 动作类型
		 * @param path 路径
		 * @param costPerCell 移动每格消耗 
		 * @param startPos 起点（如果上一步没走完则不需要）
		 */		
		public function reset(action:int, path:Vector.<AStarNode>, costPerCell:Number, startPos:Point = null):void
		{
			if (path.length == 0)
			{
				return;
			}
			_actionType = action;
			_path = path;
			_costPerCell = costPerCell;
			_isFinish = false;
			if (startPos)
			{
				_curStartPos = startPos;
				_curStartPixelPos = CoorTool.cellToScene(startPos.x, startPos.y);
				nextStep();
			}
		}
		
		public function nextStep():void
		{
			_curTgtPos = _path.shift().toPoint();
			_curTgtPixelPos = CoorTool.cellToScene(_curTgtPos.x, _curTgtPos.y);
			_curStartTime = TimeTool.getCurTime();
		}
		
		public function checkStepFinish():Boolean
		{
			if (TimeTool.getCurTime() - _curStartTime >= _costPerCell)
			{
				if (_path.length)
				{
					_curStartPos = _curTgtPos.clone();
					_curStartPixelPos = CoorTool.cellToScene(_curStartPos.x, _curStartPos.y);
					nextStep();
				}
				else
				{
					_isFinish = true;
				}
				return true;
			}
			return false
		}
		
		public function get isFinish():Boolean
		{
			return _isFinish;
		}
		
		public function get curTgtPos():Point
		{
			return _curTgtPos;
		}
		
		public function getCurDirection():int
		{
			var dir:int = DirectionEnum.getDirection(_curStartPos.x, _curStartPos.y, _curTgtPos.x, _curTgtPos.y);
			return dir;
		}
		
		public function getCurPixelPos():Point
		{
			var timePast:int = TimeTool.getCurTime() - _curStartTime;
			var ratio:Number = timePast / _costPerCell;
			var curXDis:Number = MapModel.CELL_WIDTH * (_curTgtPos.x - _curStartPos.x);
			var curYDis:Number = MapModel.CELL_HEIGHT * (_curTgtPos.y - _curStartPos.y);
			var curPixelX:int = curXDis * ratio + _curStartPixelPos.x;
			var curPixelY:int = curYDis * ratio + _curStartPixelPos.y;
			return new Point(curPixelX, curPixelY);
		}
	}
}