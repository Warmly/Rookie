package
{
	import core.scene.SanguoScene;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import global.ModelEntry;
	import global.SanguoEntry;
	import global.SanguoGlobal;
	import rookie.core.resource.LoadPriority;
	import rookie.core.resource.ResType;
	import rookie.core.resource.ResUrl;
	import rookie.global.RookieEntry;
    import rookie.tool.functionHandler.FH;
	import flash.display.Sprite;

	[SWF(backgroundColor="#ffffff", frameRate="60", width="1200", height="800")]
	public class RookieSanguo extends Sprite
	{
		public function RookieSanguo()
		{
			RookieEntry.mainLoop.init(this.stage);
			
			RookieEntry.loadManager.load(SanguoGlobal.MAIN_RES_URL, LoadPriority.HIGH, FH(onMainResLoaded));
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
		}
		
		private function onMainResLoaded():void
		{
			RookieEntry.loadManager.load(SanguoGlobal.CONFIG_RES_URL, LoadPriority.HIGH, FH(onConfigResLoaded));
		}
		
		private function onConfigResLoaded():void
		{
			RookieEntry.resManager.init();
			
			var scene:SanguoScene = SanguoEntry.scene;
			scene.parent = this;
			
			ModelEntry.staticDataModel;
			
			addChild(new Stats());
			
			ModelEntry.mapModel.curMapId = 2005;
			ModelEntry.mapModel.loadMap();
		}
	}
}
