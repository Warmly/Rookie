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
	import rookie.definition.RenderEnum;
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;
	import rookie.tool.namer.namer;
	import tool.SanguoCoorTool;
	import tool.UserFactory;
    use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class SanguoScene extends RichSprite
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
			_camera = SanguoEntry.camera;
			_renderManager = RookieEntry.renderManager;
			
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
				ModelEntry.userModel.addUser(_myselfGpu.userVO);
				//_itemLayerGpu
			}
			else
			{
				_itemLayerCpu = new ItemLayerCpu();
				_itemLayerCpu.parent = this;
	
				_myselfCpu = UserFactory.getMyselfCpu();
				ModelEntry.userModel.addUser(_myselfCpu.userVO);
				_itemLayerCpu.addUser(_myselfCpu);
			}
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		private function onAddToStage(e:Event):void
		{
			init();
		}
		
		private function init():void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(Event.RESIZE, onScreenResize);
			onScreenResize();
			initLayer();
		}

		private function onScreenResize(e:Event = null):void
		{
			var focus:Point = new Point;
			
			if (SanguoDefine.GPU_RENDER_CREATURE)
			{
				focus.x = _myselfGpu.x;
				focus.y = _myselfGpu.y;
			}
			else
			{
				focus.x = _myselfCpu.x;
				focus.y = _myselfCpu.y;
			}
			
			_camera.setup(focus.x, focus.y, stage.stageWidth, stage.stageHeight);
			
			if (SanguoDefine.GPU_RENDER_MAP)
			{
				_renderManager.configBackBuffer(_camera.width, _camera.height);
				_mapLayerGpu.onScreenResize();
				if (SanguoDefine.ENABLE_MAP_GRID)
				{
				}
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
		
		private function initLayer():void
		{
			if (SanguoDefine.GPU_RENDER_CREATURE)
			{
			}
			else
			{
				RookieEntry.renderManager.addToCpuRenderQueue(_itemLayerCpu);
			}
			
			if (SanguoDefine.GPU_RENDER_MAP)
			{
			}
			else
			{
				RookieEntry.renderManager.addToCpuRenderQueue(_mapLayerCpu);
				if (SanguoDefine.ENABLE_MAP_GRID)
				{
					RookieEntry.renderManager.addToCpuRenderQueue(_mapDebugLayerCpu);
				}
			}
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			ManagerEntry.sceneManager.handleMouseDown(e);
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
