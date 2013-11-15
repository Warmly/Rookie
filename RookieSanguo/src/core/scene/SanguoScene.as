package core.scene
{
	import global.SanguoEntry;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;

	/**
	 * @author Warmly
	 */
	public class SanguoScene extends Sprite
	{
		private var _mapLayer:MapLayerCpu;

		public function SanguoScene()
		{
			_mapLayer = new MapLayerCpu();
			addChild(_mapLayer);

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
	}
}
