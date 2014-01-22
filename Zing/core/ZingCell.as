package core 
{
	import define.ZingEleEnum;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingCell extends Sprite 
	{
		private var _bg:Bitmap;
		private var _type:int;
		private var _ele:Bitmap;
		private var _index:int;
		private var _logicX:int;
		private var _logicY:int;
		
		public function ZingCell() 
		{
			_bg = new Bitmap();
			_bg.bitmapData = getZingBmd("cellBg");
			addChild(_bg);
			
			_ele = new Bitmap();
			addChild(_ele);
		}
		
		public function init(type:int):void
		{
			_type = type;
			_ele.bitmapData = getZingBmd(ZingEleEnum.getBmdName(type));
		}
		
		public function set index(val:int):void
		{
			_index = val;
		}
		
		public function setlogicPos(x:int, y:int):void
		{
			_logicX = x;
			_logicY = y;
		}
		
		public function get logicX():int
		{
			return _logicX;
		}
		
		public function get logicY():int
		{
			return _logicY;
		}
	}
}