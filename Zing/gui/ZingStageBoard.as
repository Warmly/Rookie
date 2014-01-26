package gui 
{
	import core.ZingEntry;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import tool.ZingAnimTool;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingStageBoard extends Sprite 
	{
		private var _bg:Bitmap;
		private var _txt:TextField;
		private var _num:ZingNumber;
		private var _data:int;
		
		public function ZingStageBoard() 
		{
			_bg = new Bitmap();
			_bg.bitmapData = getZingBmd("stage");
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
			if (_data != ZingEntry.zingModel.stage)
			{
				//ZingAnimTool.addAnimAt("anim1", 330, 20);
			}
			_data = ZingEntry.zingModel.stage;
			_txt.htmlText = "关：" + ZingEntry.zingModel.stage;
			_num.number = Number(ZingEntry.zingModel.stage);
		}
	}
}