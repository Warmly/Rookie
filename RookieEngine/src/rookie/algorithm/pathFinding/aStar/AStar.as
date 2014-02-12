package rookie.algorithm.pathFinding.aStar 
{
	import rookie.dataStruct.HashTable;
	/**
	 * ...
	 * @author Warmly
	 */
	public class AStar 
	{
		private var _map:Vector.<AStarNode> = new Vector.<AStarNode>();
		private var _openList:HashTable = new HashTable(int, AStarNode);
		private var _closeList:HashTable = new HashTable(int, AStarNode);
		private var _path:Vector.<AStarNode> = new Vector.<AStarNode>();
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
				switchToCloseList(_curNode);
				if (_curNode.equal(_endNode))
				{
					generatePath();
					return true;
				}
				checkNodeAround(_curNode);
			}
			return false;
		}
		
		public function get path():Vector.<AStarNode>
		{
			return _path;
		}
		
		private function addToOpenList(node:AStarNode):void
		{
			_openList.insert(node.index, node);
		}
		
		private function addToCloseList(node:AStarNode):void
		{
			_closeList.insert(node.index, node);
		}
		
		private function switchToCloseList(node:AStarNode):void
		{
			_openList.del(node.index);
			_closeList.insert(node.index);
		}
		
		private function generatePath():void
		{
			var cur:AStarNode = _endNode;
			while (!cur.equal(_startNode))
			{
				_path.unshift(cur);
				cur = cur.parentNode;
			}
		}
		
		private function getMinFValueNodeInOpenList():AStarNode
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
		
		private function checkNodeAround(node:AStarNode):void
		{
			var x:int = node.x;
			var y:int = node.y;
			//左上
			if (x-1>=0 && y-1>=0)
			{
				var nodeLeftUp:AStarNode = getNodeByCoor(x - 1, y - 1);
				checkNode(nodeLeftUp);
			}
			//上
			if (y-1>=0)
			{
				var nodeUp:AStarNode = getNodeByCoor(x, y - 1);
				checkNode(nodeUp);
			}
			//右上
			if (x+1<_width && y-1>=0)
			{
				var nodeRightUp:AStarNode = getNodeByCoor(x + 1, y - 1);
				checkNode(nodeRightUp);
			}
			//左
			if (x-1>=0)
			{
				var nodeLeft:AStarNode = getNodeByCoor(x - 1, y);
				checkNode(nodeLeft);
			}
			//右
			if (x+1<_width)
			{
				var nodeRight:AStarNode = getNodeByCoor(x + 1, y);
				checkNode(nodeRight);
			}
			//左下
			if (x-1>=0 && y+1<_height)
			{
				var nodeLeftDown:AStarNode = getNodeByCoor(x - 1, y + 1);
				checkNode(nodeLeftDown);
			}
			//下
			if (y+1<_height)
			{
				var nodeDown:AStarNode = getNodeByCoor(x, y + 1);
				checkNode(nodeDown);
			}
			//右下
			if (x+1<_width && y+1<_height)
			{
				var nodeRightDown:AStarNode = getNodeByCoor(x + 1, y + 1);
				checkNode(nodeRightDown);
			}
		}
		
		private function checkNode(node:AStarNode):void
		{
			if (!canPass(node) || isInCloseList(node))
			{
				return;
			}
			else if (!isInOpenList(node))
			{
				addToOpenList(node);
				node.parentNode = _curNode;
				node.hValue = calHValue(node, _endNode);
			}
			else
			{
				var newGVal:int = node.getCostFromNodeAround(_curNode);
				newGVal += _curNode.gValue;
				if (newGVal < node.gValue)
				{
					node.parentNode = _curNode;
				}
			}
		}
		
		private function canPass(node:AStarNode):Boolean
		{
			return node.type != AStarNodeTypeEnum.OBSTACLE;
		}
		
		private function isInOpenList(node:AStarNode):Boolean
		{
			return _openList.has(node.index);
		}
		
		private function isInCloseList(node:AStarNode):Boolean
		{
			return _closeList.has(node.index);
		}
		
		private function getNodeByCoor(x:int, y:int):AStarNode
		{
			return getNodeByIndex(x + y * _width);
		}
		
		private function getNodeByIndex(index:int):AStarNode
		{
			return _map[index];
		}
		
		private function calHValue(nodeA:AStarNode, nodeB:AStarNode):Number
		{
			var xDis:int = nodeA.x - nodeB.x;
			var yDis:int = nodeA.y - nodeB.y;
			var hValue:Number = Math.sqrt(xDis * xDis + yDis * yDis);
			return hValue;
		}
	}
}