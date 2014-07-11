package core.scene
{
	import core.creature.cpu.MyselfCpu;
	import core.creature.cpu.UserCpu;
	import core.creature.gpu.MyselfGpu;
	import core.scene.cpu.ItemLayerCpu;
	import core.scene.cpu.MapDebugLayerCpu;
	import core.scene.cpu.MapLayerCpu;
	import core.scene.gpu.ItemLayerGpu;
	import core.scene.gpu.MapLayerGpu;
	import definition.SanguoDefine;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import global.ManagerEntry;
	import global.ModelEntry;
	import rookie.core.render.IRenderItem;
	import rookie.core.render.cpu.RichSprite;
	import global.SanguoEntry;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import rookie.core.render.RenderManager;
	import rookie.core.render.RenderType;
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;
	import rookie.tool.namer.namer;
	import tool.SanguoCoorTool;
	import tool.UserFactory;
    use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class SanguoScene extends RichSprite implements IRenderItem
	{
		private var _mapLayerCpu:MapLayerCpu;
		private var _mapLayerGpu:MapLayerGpu;
		
		private var _mapDebugLayerCpu:MapDebugLayerCpu;
		
		private var _itemLayerCpu:ItemLayerCpu;
		private var _itemLayerGpu:ItemLayerGpu;
		
		private var _myselfCpu:MyselfCpu;
		private var _myselfGpu:MyselfGpu;
		
		private var _camera:SanguoCamera;
		private var _renderManager:RenderManager;

		public function SanguoScene()
		{
			if (SanguoDefine.GPU_RENDER_MAP)
			{
				_mapLayerGpu = new MapLayerGpu();
			}
			else
			{
				_mapLayerCpu = new MapLayerCpu();
				_mapLayerCpu.parent = this;
				
				if (SanguoDefine.ENABLE_MAP_GRID)
				{
					_mapDebugLayerCpu = new MapDebugLayerCpu();
					_mapDebugLayerCpu.parent = this;
				}
			}
			
			if (SanguoDefine.GPU_RENDER_CREATURE)
			{
				_itemLayerGpu = new ItemLayerGpu();
				_myselfGpu = UserFactory.getMyselfGpu();
			}
			else
			{
				_itemLayerCpu = new ItemLayerCpu();
				_itemLayerCpu.parent = this;
	
				_myselfCpu = UserFactory.getMyselfCpu();
				ModelEntry.userModel.addUser(_myselfCpu.userVO);
				_itemLayerCpu.addUser(_myselfCpu);
			}
			
			_camera = SanguoEntry.camera;
			_renderManager = RookieEntry.renderManager;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		private function onAddToStage(e:Event):void
		{
			init();
			RookieEntry.renderManager.addToCpuRenderQueue(this);
		}
		
		private function init():void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(Event.RESIZE, onScreenResize);
			
			onScreenResize();
		}

		private function onMouseDown(e:MouseEvent):void
		{
			ManagerEntry.sceneManager.handleMouseDown(e);
		}

		private function onScreenResize(e:Event = null):void
		{
			_camera.setup(_myselfCpu.x - stage.stageWidth * 0.5, _myselfCpu.y - stage.stageHeight * 0.5, stage.stageWidth, stage.stageHeight);
			this.x = -_camera.xInScene;
			this.y = -_camera.yInScene;
			if (SanguoDefine.GPU_RENDER_MAP)
			{
				_renderManager.configBackBuffer(_camera.width, _camera.height);
				_mapLayerGpu.onScreenResize();
			}
			else
			{
				_mapLayerCpu.onScreenResize();
				if (SanguoDefine.ENABLE_MAP_GRID)
				{
					_mapDebugLayerCpu.onScreenResize();
				}
			}
		}
		
		public function render():void
		{
			if (SanguoDefine.GPU_RENDER_CREATURE)
			{
			}
			else
			{
				_myselfCpu.render();
				_itemLayerCpu.updateDepth();
			}
			if (SanguoDefine.GPU_RENDER_MAP)
			{
				_mapLayerGpu.render();
			}
			else
			{
				_mapLayerCpu.render();
				if (SanguoDefine.ENABLE_MAP_GRID)
				{
					_mapDebugLayerCpu.render();
				}
			}
			moveScene();
		}
		
		private function moveScene():void
		{
			_camera.move(_myselfCpu.x - _camera.width * 0.5, _myselfCpu.y - _camera.height * 0.5);
			this.x = - _camera.xInScene
			this.y = - _camera.yInScene;
		}
		
		public function dispose():void
		{
		}
		
		public function get renderType():int
		{
			return RenderType.GPU;
		}
		
		public function get key():String
		{
			return namer("SanguoScene");
		}
		
		public function get myselfCpu():MyselfCpu
		{
			return _myselfCpu;
		}
		
		public function get mapLayerCpu():MapLayerCpu 
		{
			return _mapLayerCpu;
		}
		
		public function get itemLayerCpu():ItemLayerCpu 
		{
			return _itemLayerCpu;
		}
	}
}
