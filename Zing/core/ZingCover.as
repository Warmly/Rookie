package core 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import gui.ZingBtn;
	import tool.getZingBmd;
	
	/**
	 * 开始界面
	 * @author Warmly
	 */
	public class ZingCover extends Sprite 
	{
		private var _bg:Bitmap;
		private var _startBtn:ZingBtn;
		
		public function ZingCover() 
		{
			_bg = new Bitmap();
			_bg.bitmapData = getZingBmd("cover");
			addChild(_bg);
			
			_startBtn = new ZingBtn(new startBtn());
			_startBtn.x = 320;
			_startBtn.y = 480;
			addChild(_startBtn);
			
			_startBtn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void
		{
			ZingEntry.zingLogic.gameStart();
		}
	}
}