package gui 
{
	import core.ZingEntry;
	import flash.display.Sprite;
	import flash.text.TextField;
	import tool.ZingAnimTool;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingStageBoard extends Sprite 
	{
		private var _txt:TextField;
		private var _num:ZingNumber;
		private var _data:int;
		
		public function ZingStageBoard() 
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
			if (_data != ZingEntry.zingModel.stage)
			{
				ZingAnimTool.addAnimAt("anim1", 330, 20);
			}
			_data = ZingEntry.zingModel.stage;
			_txt.htmlText = "关：" + ZingEntry.zingModel.stage;
			_num.number = Number(ZingEntry.zingModel.stage);
		}
	}
}