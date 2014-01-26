package core 
{
	import config.ZingConfig;
	import define.ZingEleEnum;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import rookie.global.RookieEntry;
	import tool.getZingBmd;
	import tool.ZingAnimTool;
	import tool.ZingSoundTool;
	
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
			_bg.scaleX = 0.75;
			_bg.scaleY = 0.75;
			_bg.alpha = 0.1;
			addChild(_bg);
			
			_ele = new Bitmap();
			addChild(_ele);
		}
		
		public function init(type:int):void
		{
			_type = type;
			_ele.bitmapData = getZingBmd(ZingEleEnum.getBmdName(type));
		}
		
		public function clear():void
		{
			addEff(_type);
			init(ZingEleEnum.EMPTY);
		}
		
		public function addEff(type:int):void
		{
			addAnimEff(type);
			addSoundEff(type);
		}
		
		public function addAnimEff(type:int):void
		{
			var xCoor:Number = this.x + ZingConfig.CELL_WIDTH * 0.5;
			var yCoor:Number = 200 + this.y + ZingConfig.CELL_HEIGHT * 0.5;
			ZingAnimTool.addAnimAt(type, xCoor, yCoor, 600);
		}
		
		public function addSoundEff(type:int):void
		{
			ZingSoundTool.playSoundEff(type);
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
		
		public function get type():int
		{
			return _type;
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