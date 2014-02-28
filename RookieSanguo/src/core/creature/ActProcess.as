package core.creature 
{
	import core.scene.MapModel;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import flash.geom.Point;
	import rookie.algorithm.pathFinding.aStar.AStarNode;
	import rookie.tool.math.RookieMath;
	import tool.SanguoCoorTool;
	import tool.SanguoTimeTool;
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
		}
		
		public function reset(action:int, path:Vector.<AStarNode>, costPerCell:Number, startPos:Point = null):void
		{
			_actionType = action;
			_path = path;
			_costPerCell = costPerCell;
			_isFinish = false;
			if (startPos)
			{
				_curStartPos = startPos;
				_curStartPixelPos = SanguoCoorTool.cellToScene(startPos.x, startPos.y);
			}
		}
		
		public function nextStep():void
		{
			_curTgtPos = _path.shift().toPoint();
			_curTgtPixelPos = SanguoCoorTool.cellToScene(_curTgtPos.x, _curTgtPos.y);
			_curStartTime = SanguoTimeTool.getCurTime();
			trace(_curTgtPos);
		}
		
		public function checkStepFinish(curPixelX:Number, curPixelY:Number):void
		{
			if (SanguoTimeTool.getCurTime() - _curStartTime >= _costPerCell)
			{
				if (_path.length)
				{
					_curStartPos = _curTgtPos.clone();
					_curStartPixelPos = SanguoCoorTool.cellToScene(_curStartPos.x, _curStartPos.y);
					nextStep();
				}
				else
				{
					_isFinish = true;
				}
			}
		}
		
		public function get isFinish():Boolean
		{
			return _isFinish;
		}
		
		public function getCurDirection():int
		{
			var dir:int = DirectionEnum.getDirection(_curStartPos.x, _curStartPos.y, _curTgtPos.x, _curTgtPos.y);
			return dir;
		}
		
		public function getCurPixelPos():Point
		{
			var timePast:int = SanguoTimeTool.getCurTime() - _curStartTime;
			var ratio:Number = timePast / _costPerCell;
			var curXDis:Number = MapModel.CELL_WIDTH * (_curTgtPos.x - _curStartPos.x);
			var curYDis:Number = MapModel.CELL_HEIGHT * (_curTgtPos.y - _curStartPos.y);
			var curPixelX:int = curXDis * ratio + _curStartPixelPos.x;
			var curPixelY:int = curYDis * ratio + _curStartPixelPos.y;
			return new Point(curPixelX, curPixelY);
		}
	}
}