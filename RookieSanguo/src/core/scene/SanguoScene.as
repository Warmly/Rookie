package core.scene
{
	import core.creature.MyselfCpu;
	import core.creature.UserCpu;
	import global.ManagerEntry;
	import rookie.core.render.RichSprite;
	import global.SanguoEntry;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;
	import tool.UserFactory;
    use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class SanguoScene extends RichSprite
	{
		private var _mapLayer:MapLayerCpu;
		private var _itemLayer:ItemLayerCpu;
		private var _myself:MyselfCpu;

		public function SanguoScene()
		{
			_mapLayer = new MapLayerCpu();
			_mapLayer.parent = this;
			
			_itemLayer = new ItemLayerCpu();
			_itemLayer.parent = this;
			
			initMyself();

			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		private function onAddToStage(e:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(Event.RESIZE, onScreenResize);
			onScreenResize();
			RookieEntry.renderManager.addToQueue(_mapLayer);
		}

		private function onMouseDown(e:MouseEvent):void
		{
			ManagerEntry.sceneManager.handleMouseDown(e);
		}

		private function onScreenResize(e:Event = null):void
		{
			var xDis:int = 256 * 8;
			var yDis:int = 256 * 6;
			SanguoEntry.camera.setup(xDis, yDis, stage.stageWidth, stage.stageHeight);
			this.x = -xDis;
			this.y = -yDis;
			_mapLayer.onScreenResize();
		}
		
		private function initMyself():void
		{
			_myself = UserFactory.getMyselfCpu();
			_myself.parent = _itemLayer;
			_myself.x = 256 * 9;
			_myself.y = 256 * 7;
		}

		public function get mapLayer():MapLayerCpu
		{
			return _mapLayer;
		}
		
		public function get itemLayer():ItemLayerCpu
		{
			return _itemLayer;
		}
		
		public function get myself():MyselfCpu
		{
			return _myself;
		}
	}
}
