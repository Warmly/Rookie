package tool 
{
	import flash.display.BitmapData;
	import rookie.global.RookieEntry;
	/**
	 * ...
	 * @author Warmly
	 */
	public function getZingBmd(name:String):BitmapData
	{
		return RookieEntry.resManager.bmdData.search(name);
	}
}