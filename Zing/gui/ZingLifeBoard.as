package gui 
{
	import core.ZingEntry;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingLifeBoard extends Sprite 
	{
		private var _txt:TextField;
		
		public function ZingLifeBoard() 
		{
			_txt = new TextField();
			addChild(_txt);
		}
		
		public function syn():void
		{
			_txt.htmlText = "生命：" + ZingEntry.zingModel.life;
		}
	}
}