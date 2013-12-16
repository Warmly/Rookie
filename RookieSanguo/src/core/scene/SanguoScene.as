package core.scene
{
	import rookie.core.render.RichSprite;
	import global.SanguoEntry;
	import flash.events.Event;
	import flash.events.MouseEvent;

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
		}

		private function onMouseDown(e:MouseEvent):void
		{
		}

		private function onScreenResize(e:Event = null):void
		{
			SanguoEntry.camera.setup(0, x, stage.stageWidth, stage.stageHeight);
			_mapLayer.onScreenResize();
		}

		public function get mapLayer():MapLayerCpu
		{
			return _mapLayer;
		}
	}
}
