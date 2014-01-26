package tool 
{
	import config.ZingConfig;
	import core.ZingEntry;
	import define.ZingEleEnum;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	import rookie.global.RookieEntry;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingAnimTool 
	{
		public static function addAnimAt(type:int, xCoor:Number, yCoor:Number, time:Number = 300):void
		{
			var mc:MovieClip;
			switch(type)
			{
				case ZingEleEnum.BOMB:
					mc = new animExplode();
					break;
				case ZingEleEnum.BONUS:
					mc = new animShine();
					break;
				case ZingEleEnum.CLOCK:
					mc = new animShine();
					break;
			}
			if (mc)
			{
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
}