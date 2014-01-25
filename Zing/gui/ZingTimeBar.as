package gui 
{
	import com.greensock.TweenNano;
	import config.ZingConfig;
	import core.ZingEntry;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingTimeBar extends Sprite 
	{
		private var _bg:Bitmap;
		private var _barBody:Bitmap;
		private var _barHead:Bitmap;
		private var _txt:TextField;
		
		public function ZingTimeBar() 
		{
			_bg = new Bitmap();
			_bg.bitmapData = getZingBmd("barBg");
			addChild(_bg);
			
			_barBody = new Bitmap();
			_barBody.bitmapData = getZingBmd("barBody");
			_barBody.x = 7;
			_barBody.y = 7;
			addChild(_barBody);
			
			_barHead = new Bitmap();
			_barHead.bitmapData = getZingBmd("barHead");
			_barHead.x = 7;
			_barHead.y = 7;
			addChild(_barHead);
			
			_txt = new TextField();
			_txt.height = 20;
			_txt.x = 250;
			_txt.y = 5;
			addChild(_txt);
		}
		
		public function syn():void
		{
			_txt.htmlText = "<font color='#ffffff'>" + ZingEntry.zingModel.clock + "秒</font>";
			
			var wi:Number = 575 * (ZingEntry.zingModel.clock / ZingConfig.DEFAULT_CLOCK);
			TweenNano.to(_barBody, 0.6, { width:wi } );
			
			var xi:Number = _barBody.x + wi - 1;
			TweenNano.to(_barHead, 0.6, { x:xi } );
		}
	}
}