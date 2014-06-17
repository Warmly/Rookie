package core.scene.cpu 
{
	import core.scene.MapModel;
	import core.scene.SanguoCamera;
	import flash.display.Shape;
	import flash.geom.Point;
	import global.ModelEntry;
	import global.SanguoEntry;
	import rookie.core.render.cpu.RichSprite;
	import rookie.tool.common.Color;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MapDebugLayerCpu extends RichSprite
	{
		private var _mapModel:MapModel;
		private var _camera:SanguoCamera;
		private var _mapLayer:MapLayerCpu;
		//水平
		private var _numCellW:int;
		//竖直
		private var _numCellH:int;
		private var _cells:Vector.<MapDebugCell> = new Vector.<MapDebugCell>();
		
		public function MapDebugLayerCpu() 
		{
			_mapModel = ModelEntry.mapModel;
			_camera = SanguoEntry.camera;
			_mapLayer = SanguoEntry.scene.mapLayerCpu;
		}
		
		public function refresh():void
		{
			if (_mapModel.curMapVO)
			{
				for (var j:int = 0; j < _numCellH; j++)
				{
					for (var i:int = 0; i < _numCellW; i++)
					{
						var cell:MapDebugCell = _cells[i + j * _numCellW];
						var startPos:Point = _mapLayer.getFirstBlockPos();
						cell.x = i * MapModel.CELL_WIDTH + startPos.x;
						cell.y = j * MapModel.CELL_HEIGHT + startPos.y;
					}
				}
			}
		}
		
		public function onScreenResize():void
		{
			_numCellW = _mapLayer.numBlockW * (MapModel.MAP_BLOCK_SIZE / MapModel.CELL_WIDTH);
			_numCellH = _mapLayer.numBlockH * (MapModel.MAP_BLOCK_SIZE / MapModel.CELL_HEIGHT);
			resizeCells();
		}
		
		private function resizeCells():void
		{
			var needAddNum:int = _numCellW * _numCellH - _cells.length;
			for (var i:int = 0; i < needAddNum; i++)
			{
				var cell:MapDebugCell = new MapDebugCell();
				cell.parent = this;
				_cells.push(cell);
			}
		}
	}
}

import flash.display.Shape;
import flash.text.TextField;
import rookie.core.render.cpu.RichSprite;
import rookie.tool.common.Color;
import rookie.tool.text.RookieTextField;
import rookie.tool.text.TextTool;
import core.scene.MapModel;

class MapDebugCell extends RichSprite
{
	private var _txt:RookieTextField;
	private var _shape:Shape;
	private var _obstacle:Shape;
	
	public function MapDebugCell()
	{
		_txt = TextTool.getLightTextField(MapModel.CELL_WIDTH);
		_txt.parent = this;
		
		_shape = new Shape();
		_shape.graphics.lineStyle(1, Color.BLACK_DATA);
		_shape.graphics.lineTo(MapModel.CELL_WIDTH, 0);
		_shape.graphics.lineTo(MapModel.CELL_WIDTH, MapModel.CELL_HEIGHT);
		_shape.graphics.lineTo(0, MapModel.CELL_HEIGHT);
		_shape.graphics.lineTo(0, 0);
		_shape.graphics.endFill();
		addChild(_shape);
	}
}