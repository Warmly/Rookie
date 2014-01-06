package tool 
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Warmly
	 */
	public class SanguoTimeTool 
	{
		public function SanguoTimeTool() 
		{
		}
		
		public static function getCurTime():int
		{
			return getTimer();
		}
	}
}