package gui 
{
	import core.ZingEntry;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingOverBoard extends Sprite 
	{
		private var _bg:Bitmap;
		private var _bg1:Bitmap;
		private var _curScore:ZingNumber;
		private var _return:ZingBtn;
		
		public function ZingOverBoard() 
		{
			_bg = new Bitmap();
			_bg.bitmapData = getZingBmd("over");
			addChild(_bg);
			
			_bg1 = new Bitmap();
			_bg1.bitmapData = getZingBmd("score");
			_bg1.x = 130;
			_bg1.y = 160;
			addChild(_bg1);
			
			_curScore = new ZingNumber();
			_curScore.x = _bg1.x + _bg1.width + 30;
			_curScore.y = 160;
			addChild(_curScore);
			
			_return = new ZingBtn(new returnBtn());
			_return.x = 200;
			_return.y = 330;
			addChild(_return);
			
			_return.addEventListener(MouseEvent.CLICK, onReturn);
		}
		
		private function onReturn(e:MouseEvent):void
		{
			this.y = -600;
			ZingEntry.zingCover.visible = true;
		}
		
		public function syn():void
		{
			_curScore.number = ZingEntry.zingModel.score;
		}
	}
}