package rookie.algorithm.pathFinding.aStar 
{
	import flash.utils.Dictionary;
	import rookie.dataStruct.HashTable;
	import rookie.tool.log.log;
	import rookie.tool.math.RookieMath;
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
		
		public function initMap(map:Vector.<AStarNode>):void
		{
			_map = map;
		}
		
		public function init(startX:int, startY:int, endX:int, endY:int):void
		{
			_startNode = _map[startX + startY * _width];
			_endNode = _map[endX + endY * _width];
			checkEndNode();
			reset();
		}
		
		private function reset():void
		{
			_openList.clear();
			_closeList.clear();
			_path.length = 0;
		}
		
		public function findPath():Boolean
		{
			addToOpenList(_startNode);
			while (_openList.length)
			{
				_curNode = getMinFValueNodeInOpenList();
				//log(_curNode.x + "," + _curNode.y);
				switchToCloseList(_curNode);
				if (_curNode.equal(_endNode))
				{
					generatePath();
					//traceResult();
					return true;
				}
				checkNodeAround(_curNode);
			}
			log("Path find failed !");
			return false;
		}
		
		/**
		 * 当终点不可走时，水漫法寻找距离终点最近的可走点
	     */
		private function checkEndNode():void 
		{
			if (_endNode.type == AStarNodeEnum.OBSTACLE)
			{
				var disX:int = RookieMath.abs(_startNode.x - _endNode.x);
				var disY:int = RookieMath.abs(_startNode.y - _endNode.y);
				var maxRange:int = RookieMath.max(disX, disY);
				var fromX:int = 0;
				var toX:int = 0;
				var fromY:int = 0;
				var toY:int = 0;
				//已经检查过的节点, (index, true)
				var checkedNode:HashTable = new HashTable(int, Boolean);
				//当前一圈节点
				var curAroundNode:Vector.<AStarNode> = new Vector.<AStarNode>();
				for (var i:int = 1; i <= maxRange; i++) 
				{
					curAroundNode.length = 0;
					fromX = RookieMath.max(0, _endNode.x - i);
			        toX = RookieMath.min(_endNode.x + i, _width - i);
			        fromY = RookieMath.max(0, _endNode.y - i);
			        toY = RookieMath.min(_endNode.y + i, _height - i);
					for (var y:int = fromY; y <= toY; y++) 
					{
						for (var x:int = fromX; x <= toX; x++) 
						{
							if (!checkedNode.has(x + y * _width))
							{
								var node:AStarNode = getNodeByCoor(x, y);
								if (node.type != AStarNodeEnum.OBSTACLE)
								{
									curAroundNode.push(node);
								}
								checkedNode.insert(x + y * _width, true);
							}
						}
					}
					for each (var nd:AStarNode in curAroundNode) 
					{
						var nearestNd:AStarNode;
						if (!nearestNd || (calHValue(nd, _endNode) < calHValue(nearestNd, _endNode)))
						{
							nearestNd = nd;
						}
					}
					if (nearestNd)
					{
						_endNode = nearestNd;
						return;
					}
				}
				_endNode = _startNode;
			}
		}
		
		/**
		 * 不包含起点，包含终点 
	     */
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
			_closeList.insert(node.index, node);
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
			var content:Dictionary = _openList.content;
			for each(var i:AStarNode in content)
			{
				if (!rt || i.fValue <= rt.fValue)
				{
					rt = i;
				}
			}
			return rt;
		}
		
		private function checkNodeAround(node:AStarNode):void
		{
			var fromX:int = RookieMath.max(0, node.x - 1);
			var toX:int = RookieMath.min(node.x + 1, _width - 1);
			var fromY:int = RookieMath.max(0, node.y - 1);
			var toY:int = RookieMath.min(node.y + 1, _height - 1);
			for (var j:int = fromY; j <= toY; j++) 
			{
				for (var i:int = fromX; i <= toX; i++) 
				{
					checkNode(getNodeByCoor(i, j));
				}
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
			return node.type != AStarNodeEnum.OBSTACLE;
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
			var xDis:int = RookieMath.abs(nodeA.x - nodeB.x);
			var yDis:int = RookieMath.abs(nodeA.y - nodeB.y);
			var hValue:Number = xDis + yDis;
			return hValue;
		}
		
		public function parseArrToMap(arr:Array, width:int, height:int):void
		{
			_width = width;
			_height = height;
			_map.length = 0;
			var length:int = arr.length;
			for (var j:int = 0; j < height; j++)
			{
				for (var i:int = 0; i < width; i++)
				{
					var node:AStarNode = new AStarNode();
					node.init(i, j, i + j * width, arr[i + j * width]);
					_map.push(node);
				}
			}
		}
		
		private function traceResult():void
		{
			log("======本次寻路======");
			for (var j:int = 0; j < _height;j++)
			{
				var rowStr:String = "";
				for (var i:int = 0; i < _width; i++)
				{
					var node:AStarNode = _map[i + j * _width];
					if (node.equal(_startNode))
					{
						rowStr += "S ";
					}
					else if (node.equal(_endNode))
					{
						rowStr += "E ";
					}
					else if (isInPath(node))
					{
						rowStr += "P "
					}
					else
					{
						rowStr += node.type + " ";
					}
				}
				log(rowStr);
			}
		}
		
		private function isInPath(node:AStarNode):Boolean
		{
			for each(var i:AStarNode in _path)
			{
				if (i.equal(node))
				{
					return true;
				}
			}
			return false;
		}
	}
}