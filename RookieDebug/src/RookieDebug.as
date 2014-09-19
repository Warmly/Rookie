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
	import flash.utils.Dictionary;
	import global.SanguoEntry;
	import rookie.algorithm.pathFinding.aStar.AStar;
	import rookie.algorithm.pathFinding.aStar.AStarNode;
	import rookie.core.render.gpu.blend.RookieBlendMode;
	import rookie.core.render.gpu.factory.RookieBufferFactory;
	import rookie.core.render.gpu.factory.RookieRenderFactory;
	import rookie.core.render.gpu.ImgGpu;
	import rookie.core.resource.LoadPriorityEnum;
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

	import rookie.core.render.cpu.AnimCpuBase;
	import rookie.tool.functionHandler.fh;
	import rookie.core.resource.ResEnum;
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
			RookieEntry.loadManager.load(SanguoDefine.MAIN_RES_URL, LoadPriorityEnum.HIGH, fh(onMainResLoaded));
		}
		
		private function onMainResLoaded():void
		{
			RookieEntry.loadManager.load(SanguoDefine.CONFIG_RES_URL, LoadPriorityEnum.HIGH, fh(onConfigResLoaded));
		}
		
		private function onConfigResLoaded():void 
		{
			RookieEntry.resManager.init();
			SanguoEntry.camera.setup(0, 0, SanguoDefine.DEFAULT_CLIENT_WIDTH, SanguoDefine.DEFAULT_CLIENT_HEIGHT);
			ModelEntry.staticDataModel;
			RookieEntry.mainLoop.init(this.stage);
			//RookieEntry.renderManager.init3DRenderComponent(this.stage, fh(on3DRenderComponentReady));
			//addChild(new Stats());
		}
		
		private function on3DRenderComponentReady():void 
		{
			RookieEntry.renderManager.configBackBuffer(SanguoDefine.DEFAULT_CLIENT_WIDTH, SanguoDefine.DEFAULT_CLIENT_HEIGHT);
			RookieRenderFactory.setBasicRenderState();
		}
	}
}
