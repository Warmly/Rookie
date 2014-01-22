package tool 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingAlign 
	{
		public static function alignToCenter(tgt:DisplayObject):void
		{
			if (tgt.parent)
			{
				tgt.x = int((tgt.parent.width - tgt.width) * 0.5);
				tgt.y = int((tgt.parent.height - tgt.height) * 0.5);
			}
		}
		
		public static function alignTo(tgt:DisplayObject, ref:DisplayObject):void
		{
			tgt.x = ref.x;
			tgt.y = ref.y;
		}
	}
}