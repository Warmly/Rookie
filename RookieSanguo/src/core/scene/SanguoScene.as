package core.scene
{
	import core.creature.MyselfCpu;
	import core.creature.UserCpu;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import global.ManagerEntry;
	import global.ModelEntry;
	import rookie.core.render.IRenderItem;
	import rookie.core.render.RichSprite;
	import global.SanguoEntry;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;
	import tool.SanguoCoorTool;
	import tool.UserFactory;
    use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class SanguoScene extends RichSprite implements IRenderItem
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

			_myself = UserFactory.getMyselfCpu();
			_myself.parent = _itemLayer;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		private function onAddToStage(e:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(Event.RESIZE, onScreenResize);
			init();
			RookieEntry.renderManager.addToQueue(this);
		}
		
		private function init():void
		{
			var meDedaultPos:Point = new Point(20, 20);
			ModelEntry.myselfModel.cellX = meDedaultPos.x;
			ModelEntry.myselfModel.cellY = meDedaultPos.y;
			_myself.synScenePixelPos(SanguoCoorTool.cellToScene(meDedaultPos.x, meDedaultPos.y));
			
			SanguoEntry.camera.setup(_myself.x - stage.stageWidth * 0.5, _myself.y - stage.stageHeight * 0.5, stage.stageWidth, stage.stageHeight);
			this.x = -SanguoEntry.camera.xInScene;
			this.y = -SanguoEntry.camera.yInScene;
			_mapLayer.onScreenResize();
		}

		private function onMouseDown(e:MouseEvent):void
		{
			ManagerEntry.sceneManager.handleMouseDown(e);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			ManagerEntry.sceneManager.handleKeyDown(e);
		}

		private function onScreenResize(e:Event = null):void
		{
			var focus:Point = SanguoEntry.camera.focus.clone();
			SanguoEntry.camera.setup(focus.x - stage.stageWidth * 0.5, focus.y - stage.stageHeight * 0.5, stage.stageWidth, stage.stageHeight);
			this.x = -SanguoEntry.camera.xInScene;
			this.y = -SanguoEntry.camera.yInScene;
			_mapLayer.onScreenResize();
		}
		
		public function render():void
		{
			_mapLayer.refresh();
			_myself.refresh();
		}
		
		public function dispose():void
		{
			RookieEntry.renderManager.removeFromQueue(this);
		}
		
		public function get key():String
		{
			return "SanguoScene" + "[" + name + "]";
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
