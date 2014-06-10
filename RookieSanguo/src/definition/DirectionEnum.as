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
		public static const DIRECTION_MAP:Array = [];
		DIRECTION_MAP[TWO_DIRECTION.length] = [];
		DIRECTION_MAP[THREE_DIRECTION.length] = [];
		DIRECTION_MAP[FIVE_DIRECTION.length] = [];
		public static const REVERSE_MAP:Array = [];
		REVERSE_MAP[TWO_DIRECTION.length] = [];
		REVERSE_MAP[THREE_DIRECTION.length] = [];
		REVERSE_MAP[FIVE_DIRECTION.length] = [];
		
		DIRECTION_MAP[2][UP] = RIGHT_UP;
		DIRECTION_MAP[2][RIGHT_UP] = RIGHT_UP;
		DIRECTION_MAP[2][RIGHT] = RIGHT_DOWN;
		DIRECTION_MAP[2][RIGHT_DOWN] = RIGHT_DOWN;
		DIRECTION_MAP[2][DOWN] = RIGHT_DOWN;
		DIRECTION_MAP[2][LEFT_DOWN] = RIGHT_DOWN;
		DIRECTION_MAP[2][LEFT] = RIGHT_DOWN;
		DIRECTION_MAP[2][LEFT_UP] = RIGHT_UP;
		
		DIRECTION_MAP[3][UP] = RIGHT_UP;
		DIRECTION_MAP[3][RIGHT_UP] = RIGHT_UP;
		DIRECTION_MAP[3][RIGHT] = RIGHT;
		DIRECTION_MAP[3][RIGHT_DOWN] = RIGHT_DOWN;
		DIRECTION_MAP[3][DOWN] = RIGHT_DOWN;
		DIRECTION_MAP[3][LEFT_DOWN] = RIGHT_DOWN;
		DIRECTION_MAP[3][LEFT] = RIGHT;
		DIRECTION_MAP[3][LEFT_UP] = RIGHT_UP;
		
		DIRECTION_MAP[5][UP] = UP;
		DIRECTION_MAP[5][RIGHT_UP] = RIGHT_UP;
		DIRECTION_MAP[5][RIGHT] = RIGHT;
		DIRECTION_MAP[5][RIGHT_DOWN] = RIGHT_DOWN;
		DIRECTION_MAP[5][DOWN] = DOWN;
		DIRECTION_MAP[5][LEFT_DOWN] = RIGHT_DOWN;
		DIRECTION_MAP[5][LEFT] = RIGHT;
		DIRECTION_MAP[5][LEFT_UP] = RIGHT_UP;
		
		REVERSE_MAP[2][UP] = true;
		REVERSE_MAP[2][RIGHT_UP] = false;
		REVERSE_MAP[2][RIGHT] = false;
		REVERSE_MAP[2][RIGHT_DOWN] = false;
		REVERSE_MAP[2][DOWN] = true;
		REVERSE_MAP[2][LEFT_DOWN] = true;
		REVERSE_MAP[2][LEFT] = true;
		REVERSE_MAP[2][LEFT_UP] = true;
		
		REVERSE_MAP[3][UP] = true;
		REVERSE_MAP[3][RIGHT_UP] = false;
		REVERSE_MAP[3][RIGHT] = false;
		REVERSE_MAP[3][RIGHT_DOWN] = false;
		REVERSE_MAP[3][DOWN] = true;
		REVERSE_MAP[3][LEFT_DOWN] = true;
		REVERSE_MAP[3][LEFT] = true;
		REVERSE_MAP[3][LEFT_UP] = true;
		
		REVERSE_MAP[5][UP] = false;
		REVERSE_MAP[5][RIGHT_UP] = false;
		REVERSE_MAP[5][RIGHT] = false;
		REVERSE_MAP[5][RIGHT_DOWN] = false;
		REVERSE_MAP[5][DOWN] = false;
		REVERSE_MAP[5][LEFT_DOWN] = true;
		REVERSE_MAP[5][LEFT] = true;
		REVERSE_MAP[5][LEFT_UP] = true;
	
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
