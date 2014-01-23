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
			var cellBgCls:Class = getDefinitionByName("cellBg") as Class;
			var cellBgBmd:BitmapData = new cellBgCls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("cellBg", cellBgBmd);
			
			var bg1Cls:Class = getDefinitionByName("bg1") as Class;
			var bg1Bmd:BitmapData = new bg1Cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("bg1", bg1Bmd);
			
			var bg2Cls:Class = getDefinitionByName("bg2") as Class;
			var bg2Bmd:BitmapData = new bg2Cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("bg2", bg2Bmd);
			
			var grid1Cls:Class = getDefinitionByName("grid1") as Class;
			var grid1Bmd:BitmapData = new grid1Cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("grid1", grid1Bmd);
			
			var targetCls:Class = getDefinitionByName("target") as Class;
			var targetBmd:BitmapData = new targetCls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("target", targetBmd);
			
			var obstacleCls:Class = getDefinitionByName("obstacle") as Class;
			var obstacleBmd:BitmapData = new obstacleCls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("obstacle", obstacleBmd);
			
			var guiCls:Class = getDefinitionByName("gui") as Class;
			var guiBmd:BitmapData = new guiCls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("gui", guiBmd);
			
			var pathCls:Class = getDefinitionByName("path") as Class;
			var pathBmd:BitmapData = new pathCls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path", pathBmd);
			
			var path0Cls:Class = getDefinitionByName("path0") as Class;
			var path0Bmd:BitmapData = new path0Cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path0", path0Bmd);
			
			var path45Cls:Class = getDefinitionByName("path45") as Class;
			var path45Bmd:BitmapData = new path45Cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path45", path45Bmd);
			
			var path90Cls:Class = getDefinitionByName("path90") as Class;
			var path90Bmd:BitmapData = new path90Cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path90", path90Bmd);
			
			var path135Cls:Class = getDefinitionByName("path135") as Class;
			var path135Bmd:BitmapData = new path135Cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path135", path135Bmd);
			
			var path180Cls:Class = getDefinitionByName("path180") as Class;
			var path180Bmd:BitmapData = new path180Cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path180", path180Bmd);
		}
	}
}