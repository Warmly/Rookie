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
		
		public function ZingScoreBoard() 
		{
			_txt = new TextField();
			addChild(_txt);
		}
	    
		public function syn():void
		{
			_txt.htmlText = "分数：" + ZingEntry.zingModel.score;
		}
	}
}