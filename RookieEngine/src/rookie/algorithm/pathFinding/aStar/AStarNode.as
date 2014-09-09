package rookie.algorithm.pathFinding.aStar 
{
	import flash.geom.Point;
	import rookie.algorithm.pathFinding.NodeEnum;
	import rookie.algorithm.pathFinding.PathFindingNodeBase;
	/**
	 * ...
	 * @author Warmly
	 */
	public class AStarNode extends PathFindingNodeBase
	{
		private var _fValue:Number = 0;
		private var _gValue:Number = 0;
		private var _hValue:Number = 0;
		private var _update:Boolean;
		private var _parentNode:AStarNode;
		private var _index:int;
		
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
			if (node)
			{
				_gValue = node.gValue + getCostFromParent();
			}
			else
			{
				_gValue = 0;
			}
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
		
		public function get index():int
		{
			return _index;
		}
	}
}