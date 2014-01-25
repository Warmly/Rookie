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
		private var _num:ZingNumber;
		
		public function ZingLifeBoard() 
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
			_txt.htmlText = "生命：" + ZingEntry.zingModel.life;
			_num.number = Number(ZingEntry.zingModel.life);
		}
	}
}