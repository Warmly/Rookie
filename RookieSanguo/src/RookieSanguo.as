package
{
	import cn.itamt.utils.Inspector;
	import core.scene.SanguoScene;
	import definition.SanguoDefine;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import global.ModelEntry;
	import global.SanguoEntry;
	import rookie.core.render.gpu.factory.RookieRenderFactory;
	import rookie.core.resource.LoadPriority;
	import rookie.core.resource.ResType;
	import rookie.core.resource.ResUrl;
	import rookie.global.RookieEntry;
    import rookie.tool.functionHandler.fh;
	import flash.display.Sprite;

	[SWF(backgroundColor="#ffffff", frameRate="60", width="800", height="600")]
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
			RookieEntry.loadManager.load(SanguoDefine.MAIN_RES_URL, LoadPriority.HIGH, fh(onMainResLoaded));
		}
		
		private function onMainResLoaded():void
		{
			RookieEntry.loadManager.load(SanguoDefine.CONFIG_RES_URL, LoadPriority.HIGH, fh(onConfigResLoaded));
		}
		
		private function onConfigResLoaded():void
		{
			RookieEntry.resManager.init();
			
			SanguoDefine.GPU_RENDER_MAP = true;
			SanguoDefine.GPU_RENDER_CREATURE = false;
			
			var scene:SanguoScene = SanguoEntry.scene;
			scene.parent = this;
			
			RookieEntry.mainLoop.init(this.stage);
			RookieEntry.renderManager.init3DRenderComponent(this.stage, fh(on3DRenderComponentReady));
			
			addChild(new Stats());
			
			ModelEntry.staticDataModel;
			
			ModelEntry.mapModel.curMapId = 2005;
			ModelEntry.mapModel.loadMap();
			
			SanguoEntry.keyboardHandler.init(this.stage);
		}
		
		private function on3DRenderComponentReady():void 
		{
			RookieEntry.renderManager.configBackBuffer(SanguoEntry.camera.width, SanguoEntry.camera.height);
			RookieRenderFactory.setBasicRenderState();
		}
	}
}
