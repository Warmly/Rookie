package definition
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
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
		//
		public static const DIRECTION_MAP:Array = [[],[],[],[],[],[],[],[],[]];
		public static const REVERSE_MAP:Array = [[],[],[],[],[],[],[],[],[]];
		DIRECTION_MAP[UP][2] = RIGHT_UP;
		DIRECTION_MAP[UP][3] = RIGHT_UP;
		DIRECTION_MAP[UP][5] = UP;
		DIRECTION_MAP[RIGHT_UP][2] = RIGHT_UP;
		DIRECTION_MAP[RIGHT_UP][3] = RIGHT_UP;
		DIRECTION_MAP[RIGHT_UP][5] = RIGHT_UP;
		DIRECTION_MAP[RIGHT][2] = RIGHT_DOWN;
		DIRECTION_MAP[RIGHT][3] = RIGHT;
		DIRECTION_MAP[RIGHT][5] = RIGHT;
		DIRECTION_MAP[RIGHT_DOWN][2] = RIGHT_DOWN;
		DIRECTION_MAP[RIGHT_DOWN][3] = RIGHT_DOWN;
		DIRECTION_MAP[RIGHT_DOWN][5] = RIGHT_DOWN;
		DIRECTION_MAP[DOWN][2] = RIGHT_DOWN;
		DIRECTION_MAP[DOWN][3] = RIGHT_DOWN;
		DIRECTION_MAP[DOWN][5] = DOWN;
		DIRECTION_MAP[LEFT_DOWN][2] = RIGHT_DOWN;
		DIRECTION_MAP[LEFT_DOWN][3] = RIGHT_DOWN;
		DIRECTION_MAP[LEFT_DOWN][5] = RIGHT_DOWN;
		DIRECTION_MAP[LEFT][2] = RIGHT_DOWN;
		DIRECTION_MAP[LEFT][3] = RIGHT;
		DIRECTION_MAP[LEFT][5] = RIGHT;
		DIRECTION_MAP[LEFT_UP][2] = RIGHT_UP;
		DIRECTION_MAP[LEFT_UP][3] = RIGHT_UP;
		DIRECTION_MAP[LEFT_UP][5] = RIGHT_UP;
		
		REVERSE_MAP[UP][2] = true;
		REVERSE_MAP[UP][3] = true;
		REVERSE_MAP[UP][5] = false;
		REVERSE_MAP[RIGHT_UP][2] = false;
		REVERSE_MAP[RIGHT_UP][3] = false;
		REVERSE_MAP[RIGHT_UP][5] = false;
		REVERSE_MAP[RIGHT][2] = false;
		REVERSE_MAP[RIGHT][3] = false;
		REVERSE_MAP[RIGHT][5] = false;
		REVERSE_MAP[RIGHT_DOWN][2] = false;
		REVERSE_MAP[RIGHT_DOWN][3] = false;
		REVERSE_MAP[RIGHT_DOWN][5] = false;
		REVERSE_MAP[DOWN][2] = true;
		REVERSE_MAP[DOWN][3] = true;
		REVERSE_MAP[DOWN][5] = false;
		REVERSE_MAP[LEFT_DOWN][2] = true;
		REVERSE_MAP[LEFT_DOWN][3] = true;
		REVERSE_MAP[LEFT_DOWN][5] = true;
		REVERSE_MAP[LEFT][2] = true;
		REVERSE_MAP[LEFT][3] = true;
		REVERSE_MAP[LEFT][5] = true;
		REVERSE_MAP[LEFT_UP][2] = true;
		REVERSE_MAP[LEFT_UP][3] = true;
		REVERSE_MAP[LEFT_UP][5] = true;
	
		public static function getDirection(fromX:Number, fromY:Number, toX:Number, toY:Number):int
		{
			var relative:Point = new Point(toX - fromX, toY - fromY);
			var degree:Number = Math.atan2(relative.y, relative.x) * 180 / Math.PI;
			var unit:Number = 22.5;
			var direction:int;
			if (fromX == toX && fromY == toY)
			{
				direction = -1;
			}
			else if (-unit <= degree && degree <= unit)
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
				direction = LEFT_UP;
			}
			else
			{
				direction = LEFT;
			}
			return direction;
		}
	}
}
