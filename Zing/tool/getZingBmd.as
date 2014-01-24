package tool 
{
	import flash.display.BitmapData;
	import rookie.global.RookieEntry;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Warmly
	 */
	public function getZingBmd(name:String):BitmapData
	{
		if (!name)
		{
			return null;
		}
		if (!RookieEntry.resManager.bmdData.has(name))
		{
			var cls:Class = getDefinitionByName(name) as Class;
			if (!cls)
			{
				throw new Error("没有资源["+name+"]!");
			}
			var bmd:BitmapData = new cls() as BitmapData;
			RookieEntry.resManager.bmdData.insert(name, bmd);
			return bmd;
		}
		return RookieEntry.resManager.bmdData.search(name);
	}
}