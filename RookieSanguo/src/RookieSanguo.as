package
{
	import cn.itamt.utils.Inspector;
	import core.scene.SanguoScene;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
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
			if (stage)
			{
				onAddToStage();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
			Inspector.getInstance().init(this);
		}
		
		private function onAddToStage(e:Event = null):void
		{
			if (hasEventListener(Event.ADDED_TO_STAGE))
			{
				removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			RookieEntry.mainLoop.init(this.stage);
			RookieEntry.renderManager.init3DRenderComponent(this.stage, on3DRenderComponentReady);
			RookieEntry.loadManager.load(SanguoGlobal.MAIN_RES_URL, LoadPriority.HIGH, FH(onMainResLoaded));
		}
		
		private function on3DRenderComponentReady():void 
		{
			
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
			
			addChild(new Stats());
			
			ModelEntry.staticDataModel;
			
			ModelEntry.mapModel.curMapId = 2005;
			ModelEntry.mapModel.loadMap();
		}
	}
}
