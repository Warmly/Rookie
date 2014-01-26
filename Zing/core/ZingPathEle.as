package core 
{
	import config.ZingConfig;
	import define.ZingPathVO;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingPathEle extends Sprite 
	{
		private var _bmp:Bitmap;
		
		public function ZingPathEle() 
		{
			_bmp = new Bitmap();
			_bmp.x = -ZingConfig.PATH_ELE_SIZE * 0.5;
			_bmp.y = -ZingConfig.PATH_ELE_SIZE * 0.5;
			addChild(_bmp);
		}
		
		public function setSource(vo:ZingPathVO):void
		{
			var str:String = vo.type >= 0 ? ("path" + vo.type):"path";
			_bmp.bitmapData = getZingBmd(str);
			_bmp.smoothing = true
			this.rotation = vo.rotation;
		}
	}
}