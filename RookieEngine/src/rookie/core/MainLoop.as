package rookie.core
{
	import flash.events.Event;
	import flash.display.Stage;
	import rookie.global.RookieEntry;

	/**
	 * @author Warmly
	 */
	public class MainLoop
	{
		private var _stage:Stage;
		private var _queue:Vector.<IMainLoop> = new Vector.<IMainLoop>();

		public function MainLoop()
		{
		}

		public function init(stage:Stage):void
		{
			_stage = stage;
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function add(item:IMainLoop):void
		{
			_queue.push(item);
		}

		private function onEnterFrame(event:Event):void
		{
			for each (var item:IMainLoop in _queue) 
			{
				item.onEnterFrame();
			}
		}
	}
}
