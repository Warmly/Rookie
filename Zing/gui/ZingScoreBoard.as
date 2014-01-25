package gui 
{
	import core.ZingEntry;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingScoreBoard extends Sprite 
	{
		private var _txt:TextField;
		private var _num:ZingNumber;
		
		public function ZingScoreBoard() 
		{
			_txt = new TextField();
			addChild(_txt);
			
			_num = new ZingNumber();
			_num.x = 30;
			_num.y = 30;
			addChild(_num);
		}
	    
		public function syn():void
		{
			_txt.htmlText = "分数：" + ZingEntry.zingModel.score;
			_num.number = Number(ZingEntry.zingModel.score);
		}
	}
}