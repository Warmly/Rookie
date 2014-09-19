package rookie.algorithm.pathFinding 
{
	
	/**
	 * 寻路算法通用接口
	 * @author Warmly
	 */
	public interface IPathFinding 
	{
		/**
		 * 初始化格子模型
		 * @param gridData 网格数据
		 * @param width    网格宽
		 * @param height   网格高
		 */
		function init(gridData:*, width:int, height:int):void
		
		/**
		 * 寻路
		 */
		function findPath(startX:int, startY:int, endX:int, endY:int):Boolean
		
		/**
		 * 获取路径(不包含起点，包含终点)
		 */
		function get path():*
		
		/**
		 * 重置
		 */
		function reset():void
	}
}