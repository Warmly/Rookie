package rookie.core.resource
{
	import rookie.namespace.Rookie;

	import flash.events.Event;

	/**
	 * @author Warmly
	 */
	public class LoadThreadEvent extends Event
	{
		Rookie static const ITEM_LOADED:String = "LoadThreadEvent_ItemLoaded";
		Rookie static const LOAD_ERROR:String = "LoadThreadEvent_LoadError";

		public function LoadThreadEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
