package core.creature 
{
	import core.scene.MapModel;
	import definition.ActionEnum;
	import flash.geom.Point;
	import rookie.tool.math.RookieMath;
	import tool.SanguoCoorTool;
	import tool.SanguoTimeTool;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ActProcess 
	{
		private var _actionType:int;
		private var _startTime:int;
		private var _endTime:int;
		private var _startPos:Point;
		private var _endPos:Point;
		
		private var _totalTime:int;
		private var _totalXDis:int;
		private var _totalYDis:int;
		private var _startPixelPos:Point;
		
		public function ActProcess(action:int, startTime:int, endTime:int, startPos:Point, endPos:Point) 
		{
			_actionType = action;
			_startTime = startTime;
			_endTime = endTime;
			_startPos = startPos;
			_endPos = endPos;
			
			_totalTime = endTime - startTime;
			_totalXDis = MapModel.CELL_WIDTH * (_endPos.x - _startPos.x);
			_totalYDis = MapModel.CELL_HEIGHT * (_endPos.y - _startPos.y);
			_startPixelPos = SanguoCoorTool.cellToScene(_startPos.x, _startPos.y);
		}
		
		public function get isFinish():Boolean
		{
			var curTime:int = SanguoTimeTool.getCurTime();
			return _endTime <= curTime; 
		}
		
		public function getCurPixelPos():Point
		{
			var curTime:int = SanguoTimeTool.getCurTime();
			var timePast:int = curTime - _startTime;
			var ratio:Number = timePast / _totalTime;
			var curPixelX:int = _totalXDis * ratio + _startPixelPos.x;
			var curPixelY:int = _totalYDis * ratio + _startPixelPos.y;
			return new Point(curPixelX, curPixelY);
		}
	}
}