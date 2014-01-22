package core 
{
	import config.ZingStageVO;
	import define.ZingState;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingModel 
	{
		//游戏状态
		public var state:int;
		//当前关限时
		public var clock:int;
		//得分
		public var score:int;
		//生命
		public var life:int = 10;
		//当前关
		public var stage:int = 1;
		//划的路径，待优化
		public var path:Vector.<Point> = new Vector.<Point>(); 
		
		public function getCurStageVO():ZingStageVO
		{
			return ZingEntry.zingConfig.getStageVO(stage);
		}
	}
}