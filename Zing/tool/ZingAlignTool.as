package tool 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingAlignTool 
	{
		public static function alignToCenter(tgt:DisplayObject, ref:DisplayObject = null):void
		{
			if (ref == null)
			{
				ref = tgt.parent;
			}
			if (ref)
			{
				tgt.x = int((ref.width - tgt.width) * 0.5);
				tgt.y = int((ref.height - tgt.height) * 0.5);
			}
		}
		
		public static function alignTo(tgt:DisplayObject, ref:DisplayObject):void
		{
			tgt.x = ref.x;
			tgt.y = ref.y;
		}
	}
}