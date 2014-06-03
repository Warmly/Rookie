package
{
	import cn.itamt.utils.Inspector;
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
			/*var imgGpu:ImgGpu = new ImgGpu(new ResUrl(311, 26, 310));
			imgGpu.x = 300;
			imgGpu.y = 300;
			
			var imgGpu1:ImgGpu = new ImgGpu(new ResUrl(311, 26, 300));
			imgGpu1.x = 330;
			imgGpu1.y = 330;*/
			
			/*var anim:AnimGpu = new AnimGpu(new ResUrl(311, 26, 139));
			anim.x = 100;
			anim.y = 100;*/
			
			//imgGpu1.selfStartRender();
			//imgGpu.selfStartRender();
			//anim.selfStartRender();
			
			/*var anim:AnimCpu = new AnimCpu(new ResUrl(311, 26, 139));
			anim.x = 100;
			anim.y = 100;
			anim.parent = this;*/
			
			var container:Sprite = new Sprite();
			addChild(container);
			var anim1:AnimCpu = new AnimCpu(new ResUrl(311, 36, 9));
			anim1.x = 0;
			anim1.y = 0;
			anim1.parent = container;
			//anim1.scaleX = anim1.scaleY = 0.6;
			container.scaleX = container.scaleY = 0.6;
			
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
			text.x = 400;
			text.y = 0;
			text.scrollRect = new Rectangle(-100, 0, text.width, text.height);
			//text.scrollRect.x = 600;
			addChild(text);
			
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(Color.BLACK_DATA);
			sp.graphics.drawRect(0, 0, 100, 100);
			sp.x = 100;
			sp.y = 400;
			sp.scrollRect = new Rectangle(0, 0, 100, 100);
			addChild(sp)
			
			sp.scaleX = 0.5;
			
			sp.addEventListener(MouseEvent.CLICK, function():void
			{
				var rect:Rectangle = sp.scrollRect;
				rect.y -= 2;
				sp.scrollRect = rect;
			})
		}
	}
}
