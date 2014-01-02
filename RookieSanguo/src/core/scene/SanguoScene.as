package core.scene
{
	import rookie.core.render.RichSprite;
	import global.SanguoEntry;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;
    use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class SanguoScene extends RichSprite
	{
		private var _mapLayer:MapLayerCpu;

		public function SanguoScene()
		{
			_mapLayer = new MapLayerCpu();
			_mapLayer.parent = this;

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
		}

		private function onScreenResize(e:Event = null):void
		{
			var xDis:int = 256*6;
			var yDis:int = 256*6;
			SanguoEntry.camera.setup(xDis, yDis, stage.stageWidth, stage.stageHeight);
			this.x = -xDis;
			this.y = -yDis;
			_mapLayer.onScreenResize();
		}

		public function get mapLayer():MapLayerCpu
		{
			return _mapLayer;
		}
	}
}
