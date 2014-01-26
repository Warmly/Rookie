package core 
{
	import config.ZingConfig;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingGame extends Sprite 
	{
		private var _scene:ZingScene;
		private var _gui:ZingGUI;
		private var _cover:ZingCover;
		
		public function ZingGame() 
		{
			_scene = ZingEntry.zingScene;
			addChild(_scene);
			
			_gui = ZingEntry.zingGUI;
			addChild(_gui);
			
			_cover = ZingEntry.zingCover;
			addChild(_cover);
			
			addEventListener(Event.ADDED_TO_STAGE , onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			onScreenResize();
			stage.addEventListener(Event.RESIZE, onScreenResize);
		}
		
		private function onScreenResize(e:Event = null):void
		{
			var xScale:Number = stage.stageWidth / ZingConfig.DEFAULT_CLIENT_WIDTH;
			var yScale:Number = stage.stageHeight / ZingConfig.DEFAULT_CLIENT_HEIGHT;
			var scale:Number = Math.min(xScale, yScale);
			ZingConfig.CLIENT_SCALE = scale;
			//ZingConfig.updateConfig();
			width = scale * ZingConfig.DEFAULT_CLIENT_WIDTH;
			height = scale * ZingConfig.DEFAULT_CLIENT_HEIGHT;;
		}
	}
}