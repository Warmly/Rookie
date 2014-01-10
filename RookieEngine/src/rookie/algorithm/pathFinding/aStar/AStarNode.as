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
		public var type:int = AStarNodeTypeEnum.NORMAL;
		public var index:int;
		public var x:int;
		public var y:int;
		
		public function AStarNode() 
		{
		}
		
		public function set parentNode(node:AStarNode):void
		{
			_parentNode = node;
			
			gValue = node.fValue + getCostFromParent();
		}
		
		private function getCostFromParent():Number
		{
			if (_parentNode.x == this.x || _parentNode.y == this.y)
			{
				return 1;
			}
			else
			{
				return 1.4;
			}
		}
		
		public function set gValue(val:Number):void
		{
			if (val != _gValue)
			{
				_gValue = val;
				_update = true;
			}
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
	}
}