package gui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingOverBoard extends Sprite 
	{
		private var _bg:Bitmap;
		
		public function ZingOverBoard() 
		{
			_bg = new Bitmap();
			_bg.bitmapData = getZingBmd("over");
			addChild(_bg);
		}
	}
}