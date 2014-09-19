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
	import rookie.core.IMainLoop;
	import rookie.core.render.cpu.RichSprite;
	import global.SanguoEntry;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import rookie.core.render.RenderManager;
	import rookie.definition.RenderEnum;
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;
	import rookie.tool.namer.namer;
	import tool.UserFactory;
    use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class SanguoScene extends RichSprite implements IMainLoop
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
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		private function onAddToStage(e:Event):void
		{
			init();
		}
		
		private function init():void
		{
			initLayer();
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(Event.RESIZE, onScreenResize);
			onScreenResize();
		}

		private function onScreenResize(e:Event = null):void
		{
			updateCamera();
			if (SanguoDefine.GPU_RENDER_SCENE)
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
		
		public function onEnterFrame():void
		{
			RookieEntry.renderManager.clear();
			if (SanguoDefine.GPU_RENDER_SCENE)
			{
				_myselfGpu.update();
				updateCamera();
				_mapLayerGpu.render();
				_itemLayerGpu.render();
				//_myselfGpu.render();
			}
			else
			{
				_myselfCpu.render();
				updateCamera();
				_mapLayerCpu.render();
				_mapLayerCpu.x = -_camera.xInScene;
				_mapLayerCpu.y = -_camera.yInScene;
				_itemLayerCpu.render();
				_itemLayerCpu.x = -_camera.xInScene;
				_itemLayerCpu.y = -_camera.yInScene;
				if (SanguoDefine.ENABLE_MAP_GRID)
				{
					_mapDebugLayerCpu.render();
					_mapDebugLayerCpu.x = -_camera.xInScene;
					_mapDebugLayerCpu.y = -_camera.yInScene;
				}
			}
			RookieEntry.renderManager.present();
		}
		
		private function updateCamera():void
		{
			var myself:* = SanguoDefine.GPU_RENDER_SCENE ? _myselfGpu : _myselfCpu;
			var inLeftLimit:Boolean = myself.x > _camera.width * 0.5;
			var inRightLimit:Boolean = myself.x + _camera.width * 0.5 < ModelEntry.mapModel.curMapWidth;
			var inUpLimit:Boolean = myself.y > _camera.height * 0.5;
			var inDownLimit:Boolean = myself.y + _camera.height * 0.5 < ModelEntry.mapModel.curMapHeight;
			var needMoveCameraX:Boolean = inLeftLimit && inRightLimit;
			var needMoveCameraY:Boolean = inUpLimit && inDownLimit;
			var focusX:Number = needMoveCameraX ? myself.x : (!inLeftLimit?_camera.width * 0.5: ModelEntry.mapModel.curMapWidth - _camera.width * 0.5);
			var focusY:Number = needMoveCameraY ? myself.y : (!inUpLimit?_camera.height * 0.5:ModelEntry.mapModel.curMapHeight - _camera.height * 0.5);
			_camera.setup(focusX, focusY, stage.stageWidth, stage.stageHeight);
		}
		
		private function initLayer():void
		{
			if (SanguoDefine.GPU_RENDER_SCENE)
			{
				_mapLayerGpu = new MapLayerGpu();
				_itemLayerGpu = new ItemLayerGpu();
				
				if (SanguoDefine.ENABLE_MAP_GRID)
				{
				}
				
				_myselfGpu = UserFactory.getMyselfGpu();
				ModelEntry.userModel.addUser(_myselfGpu.userVO);
				_itemLayerGpu.addUser(_myselfGpu);
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
				
				_itemLayerCpu = new ItemLayerCpu();
				_itemLayerCpu.parent = this;
	
				_myselfCpu = UserFactory.getMyselfCpu();
				ModelEntry.userModel.addUser(_myselfCpu.userVO);
				_itemLayerCpu.addUser(_myselfCpu);
			}
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			ManagerEntry.sceneManager.handleMouseDown(e);
		}
		
		public function get myself():*
		{
			return SanguoDefine.GPU_RENDER_SCENE?_myselfGpu:_myselfCpu;
		}
		
		public function get mapLayerCpu():MapLayerCpu 
		{
			return _mapLayerCpu;
		}
		
		public function get mapLayerGpu():MapLayerGpu 
		{
			return _mapLayerGpu;
		}
		
		public function get itemLayerCpu():ItemLayerCpu 
		{
			return _itemLayerCpu;
		}
		
		public function get itemLayerGpu():ItemLayerGpu 
		{
			return _itemLayerGpu;
		}
	}
}
