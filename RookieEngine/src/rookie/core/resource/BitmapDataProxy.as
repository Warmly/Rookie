package rookie.core.resource 
{
	import flash.display.BitmapData;
	import rookie.core.time.SysTimeManager;
	/**
	 * BitmapData代理器，方便管理
	 * @author Warmly
	 */
	public class BitmapDataProxy 
	{
		protected var _bitmapData:BitmapData;
		protected var _lastUsedTime:Number;
		
		public function BitmapDataProxy(bmd:BitmapData) 
		{
			_bitmapData = bmd;
		}
		
		public function get bitmapData():BitmapData 
		{
			updateLastUsedTime();
			return _bitmapData;
		}
		
		public function get lastUsedTime():Number 
		{
			return _lastUsedTime;
		}
		
		private function updateLastUsedTime():void
		{
			_lastUsedTime = SysTimeManager.sysTime;
		}
	}
}