package definition 
{
	import rookie.core.resource.ResType;
	import rookie.core.resource.ResUrl;
	/**
	 * 全局定义
	 * @author Warmly
	 */
	public class SanguoDefine 
	{
		//主资源路径
		public static const MAIN_RES_URL:ResUrl = new ResUrl( -1, -1, "resource_debug", ResType.PACK_SWF, "");
		//配置资源路径
		public static const CONFIG_RES_URL:ResUrl = new ResUrl( -1, -1, "config", ResType.SPK, "");
		//是否GPU渲染地图
		public static var GPU_RENDER_MAP:Boolean = false;
		//是否显示地图格子
		public static var ENABLE_MAP_GRID:Boolean = false;
		//creature动画的Y坐标的附加偏移量，可以把creature的注册点对齐到脚下的位置
		public static const CREATURE_PART_ANIM_Y_OFFSET:int = -48;
        //creature动画播放频率		
		public static const CREATURE_PART_ANIM_FREQUENCY:int = 12;
		//普通动画播放频率
		public static const NORMAL_ANIM_FREQUENCY:int = 8;
		//移动一格耗时
		public static const MOVE_ONE_CELL_COST:int = 600;
		
		public static const CHARSET:String = "gb2312";
		
		public static const MAX_NAME_SIZE:int = 32;
	}
}