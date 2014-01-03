package definition
{
	import flash.geom.Point;
	/**
	 * 方向枚举
	 * 
	 * 8   1   2
	 *  _______
	 * |   |   |
	 *7|___|___|3
	 * |   |   |
	 * |___|___|
	 * 
	 * 6   5   4
	 * 
	 * @author Warmly
	 */
	public class DirectionEnum
	{
		public static const DEFAULT:int = DOWN;
		public static const UP:int = 1;
		public static const RIGHT_UP:int = 2;
		public static const RIGHT:int = 3;
		public static const RIGHT_DOWN:int = 4;
		public static const DOWN:int = 5;
		public static const LEFT_DOWN:int = 6;
		public static const LEFT:int = 7;
		public static const LEFT_UP:int = 8;
		//
		public static const TWO_DIRECTION:Array = [RIGHT_UP, RIGHT_DOWN];
		public static const THREE_DIRECTION:Array = [RIGHT_UP, RIGHT, RIGHT_DOWN];
		public static const FIVE_DIRECTION:Array = [UP, RIGHT_UP, RIGHT, RIGHT_DOWN, DOWN];
	
		public static function getDirection(fromX:Number, fromY:Number, toX:Number, toY:Number):int
		{
			var relative:Point = new Point(toX - fromX, toY - fromY);
			var degree:Number = Math.atan2(relative.y, relative.x);
			var unit:Number = 22.5;
			var direction:int;
			if (-unit <= degree && degree <= unit)
			{
				direction = RIGHT;
			}
			else if (unit <= degree && degree <= unit*3)
			{
				direction = RIGHT_DOWN;
			}
			else if (unit*3 <= degree && degree <= unit*5)
			{
				direction = DOWN;
			}
			else if (unit*5 <= degree && degree <= unit*7)
			{
				direction = LEFT_DOWN;
			}
			else if (-unit*3 <= degree && degree <= -unit)
			{
				direction = RIGHT_UP;
			}
			else if (-unit*5 <= degree && degree <= -unit*3)
			{
				direction = UP;
			}
			else if (-unit*7 <= degree && degree <= -unit*5)
			{
				direction = LEFT_UP
			}
			else
			{
				direction = LEFT;
			}
			return direction;
		}
	}
}
