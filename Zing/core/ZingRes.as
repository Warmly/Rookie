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
			//////普通
			var cellBgBmd:BitmapData = new cellBg() as BitmapData;
			RookieEntry.resManager.bmdData.insert("cellBg", cellBgBmd);
			
			//////背景
			var bg1Bmd:BitmapData = new bg1() as BitmapData;
			RookieEntry.resManager.bmdData.insert("bg1", bg1Bmd);
			
			var bg2Bmd:BitmapData = new bg2() as BitmapData;
			RookieEntry.resManager.bmdData.insert("bg2", bg2Bmd);
			
			var bg3Bmd:BitmapData = new bg3() as BitmapData;
			RookieEntry.resManager.bmdData.insert("bg3", bg3Bmd);
			
			var grid1Bmd:BitmapData = new grid1() as BitmapData;
			RookieEntry.resManager.bmdData.insert("grid1", grid1Bmd);
			
			var grid3Bmd:BitmapData = new grid3() as BitmapData;
			RookieEntry.resManager.bmdData.insert("grid3", grid3Bmd);
			
			//////元素
			var targetBmd:BitmapData = new target() as BitmapData;
			RookieEntry.resManager.bmdData.insert("target", targetBmd);
			
			var obstacleBmd:BitmapData = new obstacle() as BitmapData;
			RookieEntry.resManager.bmdData.insert("obstacle", obstacleBmd);
			
			var bombBmd:BitmapData = new bomb() as BitmapData;
			RookieEntry.resManager.bmdData.insert("bomb", bombBmd);
			
			var bonusBmd:BitmapData = new bonus() as BitmapData;
			RookieEntry.resManager.bmdData.insert("bonus", bonusBmd);
			
			var clockBmd:BitmapData = new clock() as BitmapData;
			RookieEntry.resManager.bmdData.insert("clock", clockBmd);
			
			//////路径
			var pathBmd:BitmapData = new path() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path", pathBmd);
			
			var path0Bmd:BitmapData = new path0() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path0", path0Bmd);
			
			var path45Bmd:BitmapData = new path45() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path45", path45Bmd);
			
			var path90Bmd:BitmapData = new path90() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path90", path90Bmd);
			
			var path135Bmd:BitmapData = new path135() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path135", path135Bmd);
			
			var path180Bmd:BitmapData = new path180() as BitmapData;
			RookieEntry.resManager.bmdData.insert("path180", path180Bmd);
			
			//////GUI
			var scoreBmd:BitmapData = new score() as BitmapData;
			RookieEntry.resManager.bmdData.insert("score", scoreBmd);
			
			var overBmd:BitmapData = new over() as BitmapData;
			RookieEntry.resManager.bmdData.insert("over", overBmd);
			
			var coverBmd:BitmapData = new cover() as BitmapData;
			RookieEntry.resManager.bmdData.insert("cover", coverBmd);
			
			var chanceBmd:BitmapData = new chance() as BitmapData;
			RookieEntry.resManager.bmdData.insert("chance", chanceBmd);
			
			var stageBmd:BitmapData = new stage() as BitmapData;
			RookieEntry.resManager.bmdData.insert("stage", stageBmd);
			
			var barHeadBmd:BitmapData = new barHead() as BitmapData;
			RookieEntry.resManager.bmdData.insert("barHead", barHeadBmd);
			
			var barBodyBmd:BitmapData = new barBody() as BitmapData;
			RookieEntry.resManager.bmdData.insert("barBody", barBodyBmd);
			
			var barBgBmd:BitmapData = new barBg() as BitmapData;
			RookieEntry.resManager.bmdData.insert("barBg", barBgBmd);
			
			var hint1Bmd:BitmapData = new hint1() as BitmapData;
			RookieEntry.resManager.bmdData.insert("hint1", hint1Bmd);
			//////声音
		}
	}
}