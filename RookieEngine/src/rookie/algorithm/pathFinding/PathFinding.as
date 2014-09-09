package rookie.algorithm.pathFinding 
{
	import rookie.algorithm.IPathFinding;
	import rookie.algorithm.pathFinding.aStar.AStar;
	/**
	 * 寻路系统
	 * @author Warmly
	 */
	public class PathFinding 
	{
		private var _fun:IPathFinding;
		private var _type:int;
		
		public function PathFinding(type:int = PathFindingEnum.ASTAR) 
		{
			_type = type;
			initFun();
		}
		
		private function initFun():void 
		{
			switch (_type) 
			{
				case PathFindingEnum.ASTAR:
					_fun = new AStar();
					break;
				default:
					_fun = new AStar();
			}
		}
		
		public function init(gridData:*, width:int, height:int):void
		{
			_fun.init(gridData, width, height);
		}
		
		public function findPath(startX:int, startY:int, endX:int, endY:int):Boolean
		{
			return _fun.findPath(startX, startY, endX, endY);
		}
		
		public function get path():*
		{
			return _fun.path;
		}
	}
}