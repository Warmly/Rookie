package core 
{
	import flash.display.BitmapData;
	import rookie.global.RookieEntry;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingRes 
	{
		public function ZingRes() 
		{
		}
		
		public function init():void
		{
			var CellBgCls:Class = getDefinitionByName("cellBg") as Class;
			var CellBgBmd:BitmapData = new CellBgCls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("cellBg", CellBgBmd);
			
			var Bg1Cls:Class = getDefinitionByName("bg1") as Class;
			var Bg1Bmd:BitmapData = new Bg1Cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("bg1", Bg1Bmd);
			
			var Bg2Cls:Class = getDefinitionByName("bg2") as Class;
			var Bg2Bmd:BitmapData = new Bg2Cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("bg2", Bg2Bmd);
			
			var TargetCls:Class = getDefinitionByName("target") as Class;
			var TargetBmd:BitmapData = new TargetCls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("target", TargetBmd);
			
			var ObstacleCls:Class = getDefinitionByName("obstacle") as Class;
			var ObstacleBmd:BitmapData = new ObstacleCls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("obstacle", ObstacleBmd);
			
			var LineCls:Class = getDefinitionByName("line") as Class;
			var LineBmd:BitmapData = new LineCls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("line", LineBmd);
			
			var GuiCls:Class = getDefinitionByName("gui") as Class;
			var GuiBmd:BitmapData = new GuiCls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("gui", GuiBmd);
		}
	}
}