package
{
	import cn.itamt.utils.Inspector;
	import core.creature.gpu.NpcGpu;
	import core.creature.gpu.UserGpu;
	import core.scene.SanguoCamera;
	import definition.SanguoDefine;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import global.SanguoEntry;
	import rookie.algorithm.pathFinding.aStar.AStar;
	import rookie.algorithm.pathFinding.aStar.AStarNode;
	import rookie.core.render.gpu.AnimGpu;
	import rookie.core.render.gpu.blend.RookieBlendMode;
	import rookie.core.render.gpu.factory.RookieBufferFactory;
	import rookie.core.render.gpu.factory.RookieRenderFactory;
	import rookie.core.render.gpu.ImgGpu;
	import rookie.core.resource.LoadPriority;
	import rookie.tool.common.Color;
	import rookie.tool.namer.namer;
	import rookie.tool.text.TextTool;
	import tool.UserFactory;
	import core.creature.cpu.UserCpu;
	import tool.NpcFactory;

	import core.scene.SanguoScene;

	import definition.DirectionEnum;
	import definition.ActionEnum;

	import core.creature.cpu.NpcCpu;

	import global.ModelEntry;

	import rookie.core.render.cpu.AnimCpu;
	import rookie.tool.functionHandler.fh;
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
		
		private function on3DRenderComponentReady():void 
		{
			var camera:SanguoCamera = SanguoEntry.camera.setup(0, 0, stage.stageWidth, stage.stageHeight);
			RookieEntry.renderManager.configBackBuffer(camera.width, camera.height);
			RookieRenderFactory.setBasicRenderState();
		}
		
		private function onMainResLoaded():void
		{
			RookieEntry.loadManager.load(SanguoDefine.CONFIG_RES_URL, LoadPriority.HIGH, fh(onConfigResLoaded));
		}
		
		private function onConfigResLoaded():void 
		{
			RookieEntry.resManager.init();
	
			ModelEntry.staticDataModel;
	
			RookieEntry.mainLoop.init(this.stage);
			RookieEntry.renderManager.init3DRenderComponent(this.stage, fh(on3DRenderComponentReady));

			addChild(new Stats());
			
			testCode();
		}
		
		private function testCode():void 
		{
			var user:UserGpu = UserFactory.getTestUserGpu();
			user.selfStartRender();
			
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
			
			trace(~0);
			
			trace(namer(SanguoScene));
		}
	}
}
