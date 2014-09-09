package rookie.algorithm.pathFinding 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Warmly
	 */
	public class PathFindingNodeBase 
	{
		protected var _type:int = NodeEnum.NORMAL;
		protected var _x:int = 0;
		protected var _y:int = 0;
		
		public function PathFindingNodeBase() 
		{
		}
		
		public function equal(node:PathFindingNodeBase):Boolean
		{
			return this.x == node.x && this.y == node.y;
		}
		
		public function toPoint():Point
		{
			return new Point(_x, _y);
		}
		
		public function get x():int 
		{
			return _x;
		}
		
		public function set x(value:int):void 
		{
			_x = value;
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function set y(value:int):void 
		{
			_y = value;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
	}
}