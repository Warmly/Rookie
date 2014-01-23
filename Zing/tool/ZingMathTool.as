package tool 
{
	import core.ZingCell;
	import define.ZingPathEleEnum;
	import define.ZingPathVO;
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
		
		public static function getPathVO(paraPt1:Point = null, paraPt2:Point = null, paraPt3:Point = null):ZingPathVO
		{
			var vo:ZingPathVO = new ZingPathVO();
			var pt1:Point;
			var pt2:Point;
			var pt3:Point;
			var anglePt:Point;
			var angle:Number;
			
			//只有一个点
			if (paraPt1 == null && paraPt2 != null && paraPt3 == null)
			{
				vo.type = ZingPathEleEnum.PATH;
				vo.rotation = 0;
			}
			//路径尾部的点
			else if (paraPt1 != null && paraPt2 != null && paraPt3 == null)
			{
				vo.type = ZingPathEleEnum.PATH_0;
				pt1 = new Point(paraPt1.x, -paraPt1.y);
				pt2 = new Point(paraPt2.x, -paraPt2.y);
				anglePt = new Point(pt2.x - pt1.x, pt2.y - pt1.y);
				angle = Math.atan2(anglePt.y, anglePt.x) * 180 / Math.PI;
				if (angle >= 0)
				{
					vo.rotation = 180 - angle;
				}
				else if (angle < 0)
				{
					vo.rotation = -180 - angle;
				}
			}
			//路径头部的点
			else if (paraPt1 == null && paraPt2 != null && paraPt3 != null)
			{
				vo.type = ZingPathEleEnum.PATH_0;
				pt2 = new Point(paraPt2.x, -paraPt2.y);
				pt3 = new Point(paraPt3.x, -paraPt3.y);
				anglePt = new Point(pt2.x - pt3.x, pt2.y - pt3.y);
				angle = Math.atan2(anglePt.y, anglePt.x) * 180 / Math.PI;
				if (angle >= 0)
				{
					vo.rotation = 180 - angle;
				}
				else if (angle < 0)
				{
					vo.rotation = -180 - angle;
				}
			}
			//路径中间的点
			else if (paraPt1 != null && paraPt2 != null && paraPt3 != null)
			{
			}
			
			return vo;
		}
	}
}