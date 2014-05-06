package
{
	import core.scene.SanguoCamera;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import global.SanguoEntry;
	import global.SanguoGlobal;
	import rookie.algorithm.pathFinding.aStar.AStar;
	import rookie.algorithm.pathFinding.aStar.AStarNode;
	import rookie.core.render.gpu.blend.RookieBlendMode;
	import rookie.core.render.gpu.factory.RookieBufferFactory;
	import rookie.core.render.gpu.ImgGpu;
	import rookie.core.resource.LoadPriority;
	import rookie.tool.text.TextTool;
	import tool.UserFactory;
	import core.creature.UserCpu;
	import tool.NpcFactory;

	import core.scene.SanguoScene;

	import definition.DirectionEnum;
	import definition.ActionEnum;

	import core.creature.NpcCpu;

	import global.ModelEntry;

	import rookie.core.render.cpu.AnimCpu;
	import rookie.tool.functionHandler.FH;
	import rookie.core.resource.ResType;
	import rookie.core.resource.ResUrl;
	import rookie.core.render.cpu.ImgCpu;
	import rookie.tool.objectPool.ObjectPool;
	import rookie.global.RookieEntry;

	import flash.display.Sprite;

	[SWF(backgroundColor="#ffffff", frameRate="60", width="800", height="600")]
	public class RookieDebug extends Sprite
	{
		public function RookieDebug()
		{
			if (stage)
			{
				onAddToStage();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
		}
		
		private function onAddToStage(e:Event = null):void 
		{
			if (hasEventListener(Event.ADDED_TO_STAGE))
			{
				removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			RookieEntry.loadManager.load(SanguoGlobal.MAIN_RES_URL, LoadPriority.HIGH, FH(onMainResLoaded));
		}
		
		private function on3DRenderComponentReady():void 
		{
			var camera:SanguoCamera = SanguoEntry.camera.setup(0, 0, stage.stageWidth, stage.stageHeight);
			RookieEntry.renderManager.configBackBuffer(camera.width, camera.height);
		}
		
		private function onMainResLoaded():void
		{
			RookieEntry.loadManager.load(SanguoGlobal.CONFIG_RES_URL, LoadPriority.HIGH, FH(onConfigResLoaded));
		}
		
		private function onConfigResLoaded():void 
		{
			RookieEntry.resManager.init();
	
			ModelEntry.staticDataModel;
	
			RookieEntry.mainLoop.init(this.stage);
			RookieEntry.renderManager.init3DRenderComponent(this.stage, FH(on3DRenderComponentReady));

			addChild(new Stats());
			
			//var anim:AnimCpu = new AnimCpu(new ResUrl(311, 26, 139));
			//anim.x = 200;
			//anim.y = 200;
			//anim.parent = this;
			
			new Test();
			
			var aStarTestArr:Array = [
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0
			];
			
			var aStar:AStar = new AStar();
			aStar.parseArrToMap(aStarTestArr, 10, 10);
			aStar.init(0, 0, 3, 5);
			aStar.findPath();
			
			var text:TextField = TextTool.getLightTextField(200, true, 20, true);
			text.htmlText = TextTool.getHtmlText("么么么么么");
			
			RookieEntry.renderManager.setBlendMode(RookieBlendMode.ALPHA);
			
			var imgGpu:ImgGpu = new ImgGpu(new ResUrl(311, 26, 310));
			imgGpu.x = 300;
			imgGpu.y = 300;
			
			var imgGpu1:ImgGpu = new ImgGpu(new ResUrl(311, 26, 300));
			imgGpu1.x = 330;
			imgGpu1.y = 330;
			
			imgGpu.selfStartRender();
			imgGpu1.selfStartRender();
		}
	}
}
