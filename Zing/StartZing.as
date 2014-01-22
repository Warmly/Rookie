package  
{
	import cn.itamt.utils.Inspector;
	import core.ZingEntry;
	import core.ZingGame;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	import rookie.core.resource.LoadPriority;
	import rookie.core.resource.ResType;
	import rookie.core.resource.ResUrl;
	import rookie.global.RookieEntry;
	import rookie.tool.functionHandler.FH;
	
	/**
	 * ...
	 * @author Warmly
	 */
	
	[SWF(backgroundColor = "#ffffff", frameRate = "60", width = "800", height = "600")]
	public class StartZing extends Sprite 
	{
		public function StartZing() 
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			Inspector.getInstance().init(this);
			
			RookieEntry.mainLoop.init(this.stage);
			
			var mainResUrl:ResUrl = new ResUrl( -1, -1, "ZingRes", ResType.SWF);
			RookieEntry.loadManager.load(mainResUrl, LoadPriority.HIGH, FH(onMainResLoaded));
		}
		
		private function onMainResLoaded():void
		{
			ZingEntry.zingRes.init();
			
			ZingEntry.zingConfig;
			
			var game:ZingGame = new ZingGame();
			addChild(game);
		}
	}
}