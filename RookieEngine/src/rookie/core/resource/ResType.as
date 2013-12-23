package rookie.core.resource
{
	import flash.utils.Dictionary;
	/**
	 * @author Warmly
	 */
	public class ResType
	{
		public static const SWF:int = 0;
		public static const PACK_SWF:int = 1;
		public static const MAP_DATA:int = 2;
		public static const JPG:int = 3;
		private static const TAIL:Dictionary = new Dictionary();
		TAIL[SWF] = ".swf";
		TAIL[PACK_SWF] = ".swf";
		TAIL[MAP_DATA] = ".map";
		TAIL[JPG] = ".jpg";
		public static function getTailByType(type:int):String
		{
			return TAIL[type];
		}
	}
}
