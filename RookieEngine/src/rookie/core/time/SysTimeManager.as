package rookie.core.time 
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Warmly
	 */
	public class SysTimeManager 
	{
		private static var _sysTime:Number;
		
		public static function get sysTime():Number
		{
			return getTimer();
		}
		
		public static function set sysTime(value:Number):void 
		{
			_sysTime = value;
		}
	}
}