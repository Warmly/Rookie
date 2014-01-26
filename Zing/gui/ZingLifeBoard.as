package gui 
{
	import core.ZingEntry;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingLifeBoard extends Sprite 
	{
		private var _bg:Bitmap;
		private var _txt:TextField;
		private var _num:ZingNumber;
		
		public function ZingLifeBoard() 
		{
			_bg = new Bitmap();
			_bg.bitmapData = getZingBmd("chance");
			addChild(_bg);
			
			_num = new ZingNumber();
			_num.x = _bg.width;
			addChild(_num);
			
			_txt = new TextField();
			_txt.y = 30;
			//addChild(_txt);
		}
		
		public function syn():void
		{
			_txt.htmlText = "生命：" + ZingEntry.zingModel.life;
			_num.number = Number(ZingEntry.zingModel.life);
		}
	}
}