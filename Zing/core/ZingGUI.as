package core 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import gui.ZingBtn;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingGUI extends Sprite 
	{
		private var _bg:Bitmap;
		private var _startBtn:ZingBtn;
		
		public function ZingGUI() 
		{
			_bg = new Bitmap();
			_bg.bitmapData = getZingBmd("gui");
			addChild(_bg);
			
			_startBtn = new ZingBtn();
			_startBtn.x = _bg.width - _startBtn.width - 120;
			_startBtn.y = _bg.height - _startBtn.height - 60;
			addChild(_startBtn);
			
			_startBtn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void
		{
			ZingEntry.zingLogic.gameStart();
		}
	}
}