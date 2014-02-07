package config 
{
	import define.ZingEleEnum;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingStageVO 
	{
		private var _id:int;
		private var _width:int;
		private var _height:int;
		private var _bg:int;
		private var _grid:int;
		private var _hint:int;
		private var _data:Array = [];
		private var _tgtPtVec:Vector.<Point> = new Vector.<Point>();
		
		public function ZingStageVO(xml:XML) 
		{
			_id = xml.@id;
			_width = xml.@width;
			_height = xml.@height;
			_bg = xml.@bg;
			_grid = xml.@grid;
			_hint = xml.@hint;
			
			var xmlList:XMLList = xml.row;
			
			for each(var i:XML in xmlList)
			{
				var arr:Array = String(i.@data).split("_");
				_data = _data.concat(arr);
			}
			
			parseTgt();
		}
		
		private function parseTgt():void
		{
			var num:int = _data.length;
			for (var i:int = 0; i < num; i++)
			{
				if (_data[i] == ZingEleEnum.TARGET)
				{
					var x:int = i % _width;
					var y:int = i / _width;
					_tgtPtVec.push(new Point(x, y));
				}
			}
		}
		
		public function getEleTypeAt(x:int, y:int):int
		{
			return int(_data[x + y * _width]);
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get width():int
		{
			return _width;
		}
		
		public function get height():int
		{
			return _height;
		}
		
		public function get bg():int
		{
			return _bg;
		}
		
		public function get grid():int
		{
			return _grid;
		}
		
		public function get hint():int
		{
			return _hint;
		}
		
		public function get data():Array
		{
			return _data;
		}
		
		public function get tgtPtVec():Vector.<Point>
		{
			return _tgtPtVec;
		}
	}
}