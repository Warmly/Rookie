package rookie.tool.math
{
	/**
	 * @author Warmly
	 */
	public class RookieMath
	{
		public static function ceil(val:Number):int
		{
			return int(val) == val ? int(val) : int(val) + 1;
		}

		public static function floor(val:Number):int
		{
			return int(val);
		}
		
		public static function abs(val:Number):Number
		{
			if (val < 0)
			{
				val = -val;
			}
			return val;
		}
	    
		public static function random():Number
		{
			return Math.random();
		}
		
		public static function randomInt(a:int, b:int):int
		{
			var temp:int = abs(a - b) + 1; 
		    return (a <= b?a:b) + floor(temp * random());
		}
		
		/**
		 * 获取下一个2次幂
		 * http://goo.gl/D9kPj
		 */		
		public static function nextPowerOfTwo(val:uint):uint
		{
			if (val > 0 && (val & (val - 1)) == 0)
			{
				return val;
			}
			else
			{
				var result:int = 1;
				while (result < val)
				{
					result <<= 1;
				}
				return result;
			}
		}
	}
}
