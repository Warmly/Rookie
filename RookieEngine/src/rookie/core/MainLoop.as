package rookie.core
{
	import rookie.global.RookieEntry;

	import flash.events.Event;
	import flash.display.Stage;

	/**
	 * @author Warmly
	 */
	public class MainLoop
	{
		private var _stage:Stage;
		//private var _mainLoopQueue:Vector.<type>

		public function MainLoop()
		{
		}

		public function init(stage:Stage):void
		{
			_stage = stage;
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event:Event):void
		{
			RookieEntry.renderManager.onEnterFrame();
			RookieEntry.timerManager.onEnterFrame();
		}
	}
}
