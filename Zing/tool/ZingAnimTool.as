package tool 
{
	import config.ZingConfig;
	import core.ZingEntry;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	import rookie.global.RookieEntry;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingAnimTool 
	{
		public static function addAnimAt(name:String, xCoor:Number, yCoor:Number, time:Number = 300):void
		{
			var mcCls:Class = getDefinitionByName("anim1") as Class;
			var mc:MovieClip = new mcCls();
			mc.x = xCoor;
			mc.y = yCoor;
			ZingEntry.zingScene.animLayer.addChild(mc);
			RookieEntry.timerManager.setTimeOut(600, function():void
			{
				if (mc.parent)
				{
					mc.parent.removeChild(mc);
				}
			});
		}
	}
}