package global 
{
	import rookie.core.resource.ResType;
	import rookie.core.resource.ResUrl;
	/**
	 * ...
	 * @author Warmly
	 */
	public class SanguoGlobal 
	{
		public static const MAIN_RES_URL:ResUrl = new ResUrl( -1, -1, "resource_debug", ResType.PACK_SWF, "");
		public static const CONFIG_RES_URL:ResUrl = new ResUrl( -1, -1, "config", ResType.SPK, "");
		public static var GPU_RENDER_MAP:Boolean = false;
		public static var ENABLE_MAP_GRID:Boolean = false;
		
		public function SanguoGlobal() 
		{
		}
	}
}