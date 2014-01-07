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
		
		public function ActProcess(action:int, startTime:int, endTime:int, startPos:Point, endPos:Point) 
		{
			_actionType = action;
			_startTime = startTime;
			_endTime = endTime;
			_startPos = startPos;
			_endPos = endPos;
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
			var ratio:Number = timePast / (_endTime - _startTime);
			var totalXDis:int = MapModel.CELL_WIDTH * (_endPos.x - _startPos.x);
			var totalYDis:int = MapModel.CELL_HEIGHT * (_endPos.y - _startPos.y);
			var startPixelPos:Point = SanguoCoorTool.cellToScene(_startPos.x, _startPos.y);
			var curPixelX:int = totalXDis * ratio + startPixelPos.x;
			var curPixelY:int = totalYDis * ratio + startPixelPos.y;
			return new Point(curPixelX, curPixelY);
		}
	}
}