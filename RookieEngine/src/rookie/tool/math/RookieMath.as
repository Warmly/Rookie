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
	}
}
