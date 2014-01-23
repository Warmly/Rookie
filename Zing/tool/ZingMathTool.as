package tool 
{
	import core.ZingCell;
	import flash.geom.Point;
	import rookie.tool.math.RookieMath;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingMathTool 
	{
		public static function isInCellResponse(stageX:Number, stageY:Number, cell:ZingCell):Boolean
		{
			var globalPt:Point = cell.localToGlobal(new Point(40, 40));
			var xMin:Number = globalPt.x - 30;
			var xMax:Number = globalPt.x + 30;
			var yMin:Number = globalPt.y - 30;
			var yMax:Number = globalPt.y + 30;
			return xMin <= stageX && stageX <= xMax && yMin <= stageY && stageY <= yMax;
		}
				
		public static function isEqualPt(pt1:Point, pt2:Point):Boolean
		{
			return pt1.x == pt2.x && pt1.y == pt2.y;
		}
		
		public static function isNeighbourPt(pt1:Point, pt2:Point):Boolean
		{
			return RookieMath.abs(pt1.x - pt2.x) <= 1 && RookieMath.abs(pt1.y - pt2.y) <= 1;
		}
	}
}