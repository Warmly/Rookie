package rookie.algorithm.pathFinding.aStar 
{
	/**
	 * ...
	 * @author Warmly
	 */
	public class AStarNode 
	{
		private var _fValue:Number = 0;
		private var _gValue:Number = 0;
		private var _hValue:Number = 0;
		private var _update:Boolean;
		private var _parentNode:AStarNode;
		private var _type:int = AStarNodeTypeEnum.NORMAL;
		private var _index:int;
		private var _x:int;
		private var _y:int;
		
		public function AStarNode() 
		{
		}
		
		public function init(x:int, y:int, index:int, type:int):void
		{
			_x = x;
			_y = y;
			_index = index;
			_type = type;
		}
		
		public function set parentNode(node:AStarNode):void
		{
			_parentNode = node;
			_gValue = node.gValue + getCostFromParent();
			_update = true;
		}
		
		public function get parentNode():AStarNode
		{
			return _parentNode;
		}
		
		public function getCostFromNodeAround(node:AStarNode):Number
		{
			if (node.x == this.x || node.y == this.y)
			{
				return 1;
			}
			else
			{
				return 1.4;
			}
		}
		
		private function getCostFromParent():Number
		{
			return getCostFromNodeAround(_parentNode);
		}
		
		public function get gValue():Number
		{
			return _gValue;
		}
		
		public function set hValue(val:Number):void
		{
			if (val != _hValue)
			{
				_hValue = val;
				_update = true;
			}
		}
		
		public function get fValue():Number
		{
			if (_update)
			{
				_fValue = _gValue + _hValue;
				_update = false;
			}
			return _fValue;
		}
		
		public function equal(node:AStarNode):Boolean
		{
			return this.x == node.x && this.y == node.y;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function get type():int
		{
			return _type;
		}
		
		public function get x():int
		{
			return _x;
		}
		
		public function get y():int
		{
			return _y;
		}
	}
}