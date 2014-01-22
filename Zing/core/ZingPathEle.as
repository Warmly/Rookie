package core 
{
	import config.ZingConfig;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingPathEle extends Sprite 
	{
		private var _bmp:Bitmap;
		
		public function ZingPathEle() 
		{
			_bmp = new Bitmap();
			addChild(_bmp);
			
			setSource();
		}
		
		public function setSource():void
		{
			_bmp.bitmapData = getZingBmd("line");
			_bmp.x = -ZingConfig.PATH_ELE_SIZE * 0.5;
			_bmp.y = -ZingConfig.PATH_ELE_SIZE * 0.5;
		}
	}
}