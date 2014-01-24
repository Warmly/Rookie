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
				anglePt = pointMinus(pt2, pt1);
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
				anglePt = pointMinus(pt2, pt3);
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
				pt1 = new Point(paraPt1.x, -paraPt1.y);
				pt2 = new Point(paraPt2.x, -paraPt2.y);
				pt3 = new Point(paraPt3.x, -paraPt3.y);
				
				pt1 = pointMinus(pt1, pt2);
				pt3 = pointMinus(pt3, pt2);
				pt2 = pointMinus(pt2, pt2);
				
				vo.type = getAngle(pt1, pt3);
				
				var angle1:Number = getAngleFromXPlus(pt1);
				var angle3:Number = getAngleFromXPlus(pt3);
				var angleHalf:Number = (angle1 + angle3) * 0.5;
				if (RookieMath.abs(angle1 - angle3) > 180)
				{
					angleHalf -= 180; 
				}
				vo.rotation = -(angleHalf - vo.type/2);
			}
			
			return vo;
		}
		
		public static function getAngle(pt1:Point, pt2:Point, round:Boolean = true):Number
		{
			var up:Number = pt1.x * pt2.x + pt1.y * pt2.y;
			var down:Number = Math.sqrt(pt1.x * pt1.x + pt1.y * pt1.y) * Math.sqrt(pt2.x * pt2.x + pt2.y * pt2.y);
			var angle:Number = Math.acos(up / down) * 180 / Math.PI;
			if (round)
			{
				angle = Math.round(angle);
			}
			return angle;
		}
		
		//从X正方向到向量的角度（0到360）
		public static function getAngleFromXPlus(pt:Point, round:Boolean = true):Number
		{
			var angle:Number = getAngle(pt, new Point(1, 0), round);
			if (pt.y >= 0)
			{
				angle = angle;
			}
			else
			{
				angle = 360 - angle;
			}
			return angle;
		}
		
		public static function pointPlus(pt1:Point, pt2:Point):Point
		{
			return new Point(pt1.x + pt2.x, pt1.y + pt2.y);
		}
		
		public static function pointMinus(pt1:Point, pt2:Point):Point
		{
			return new Point(pt1.x - pt2.x, pt1.y - pt2.y);
		}
		
		public static function pointDistance(pt1:Point, pt2:Point):Number
		{
			var xDis:Number = pt1.x - pt2.x;
			var yDis:Number = pt1.y - pt2.y;
			return Math.sqrt(xDis * xDis + yDis * yDis);
		}
		
		public static function getClosePointTo(pt1:Point, pt2:Point, ref:Point):Point
		{
			var dis1:Number = pointDistance(pt1, ref);
			var dis2:Number = pointDistance(pt2, ref);
			if (dis1 >= dis2)
			{
				return pt2;
			}
			else
			{
				return pt1;
			}
		}
	}
}