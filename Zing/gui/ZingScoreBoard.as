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
	public class ZingScoreBoard extends Sprite 
	{
		private var _bg:Bitmap;
		private var _txt:TextField;
		private var _num:ZingNumber;
		
		public function ZingScoreBoard() 
		{
			_bg = new Bitmap();
			_bg.bitmapData = getZingBmd("score");
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
			_txt.htmlText = "分数：" + ZingEntry.zingModel.score;
			_num.number = Number(ZingEntry.zingModel.score);
		}
	}
}