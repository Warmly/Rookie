package tool 
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Warmly
	 */
	public class TimeTool 
	{
		public function TimeTool() 
		{
		}
		
		public static function getCurTime():int
		{
			return getTimer();
		}
	}
}