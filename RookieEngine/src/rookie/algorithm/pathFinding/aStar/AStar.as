package rookie.algorithm.pathFinding.aStar 
{
	/**
	 * ...
	 * @author Warmly
	 */
	public class AStar 
	{
		private var _map:Vector.<AStarNode> = new Vector.<AStarNode>();
		private var _openList:Vector.<AStarNode> = new Vector.<AStarNode>();
		private var _closeList:Vector.<AStarNode> = new Vector.<AStarNode>();
		private var _width:int;
		private var _height:int;
		private var _startNode:AStarNode;
		private var _endNode:AStarNode;
		private var _curNode:AStarNode;
		
		public function AStar() 
		{
		}
		
		public function findPath():Boolean
		{
			addToOpenList(_startNode);
			while (_openList.length)
			{
				_curNode = getMinFValueNodeInOpenList();
				if ()
				{
				}
				checkNodeAround(_curNode);
			}
		}
		
		public function addToOpenList(node:AStarNode):void
		{
			_openList.push(node);
		}
		
		public function addToCloseList(node:AStarNode):void
		{
			_closeList.push(node);
		}
		
		public function getMinFValueNodeInOpenList():AStarNode
		{
			var rt:AStarNode;
			for each(var i:AStarNode in _openList)
			{
				if (rt && i.fValue < rt.fValue)
				{
					rt = i;
				}
			}
			return rt;
		}
		
		public function checkNodeAround(node:AStarNode):void
		{
			var x:int = node.x;
			var y:int = node.y;
			if (x-1>=0 && y-1>=0)
			{
				var nodeLeftUp:AStarNode = getNodeByCoor(x - 1, y - 1);
				checkNode(nodeLeftUp);
			}
			if (y-1>=0)
			{
				var nodeUp:AStarNode = getNodeByCoor(x, y - 1);
				checkNode(nodeUp);
			}
			if (x+1<_width && y-1>=0)
			{
				var nodeRightUp:AStarNode = getNodeByCoor(x + 1, y - 1);
				checkNode(nodeRightUp);
			}
			if (x-1>=0)
			{
				var nodeLeft:AStarNode = getNodeByCoor(x - 1, y);
				checkNode(nodeLeft);
			}
			if (x+1<_width)
			{
				var nodeRight:AStarNode = getNodeByCoor(x + 1, y);
				checkNode(nodeRight);
			}
			if (x-1>=0 && y+1<_height)
			{
				var nodeLeftDown:AStarNode = getNodeByCoor(x - 1, y + 1);
				checkNode(nodeLeftDown);
			}
			if (y+1<_height)
			{
				var nodeDown:AStarNode = getNodeByCoor(x, y + 1);
				checkNode(nodeDown);
			}
			if (x+1<_width && y+1<_height)
			{
				var nodeRightDown:AStarNode = getNodeByCoor(x + 1, y + 1);
				checkNode(nodeRightDown);
			}
		}
		
		public function checkNode(node:AStarNode):void
		{
			if (isInOpenList(node))
			{
			}
			else if (isInCloseList(node))
			{
			}
			else
			{
			}
		}
		
		public function isInOpenList(node:AStarNode):Boolean
		{
			for each(var i:AStarNode in _openList)
			{
				if (i.equal(node))
				{
					return true;
				}
			}
			return false;
		}
		
		public function isInCloseList(node:AStarNode):Boolean
		{
			for each(var i:AStarNode in _closeList)
			{
				if (i.equal(node))
				{
					return true;
				}
			}
			return false;
		}
		
		public function getNodeByCoor(x:int, y:int):AStarNode
		{
			return getNodeByIndex(x + y * _width);
		}
		
		public function getNodeByIndex(index:int):AStarNode
		{
			return _map[index]
		}
		
		public function calHValue(nodeA:AStarNode, nodeB:AStarNode):void
		{
			var xDis:int = nodeA.x - nodeB.x;
			var yDis:int = nodeA.y - nodeB.y;
			var hValue:Number = Math.sqrt(xDis * xDis + yDis * yDis);
			return hValue;
		}
	}
}