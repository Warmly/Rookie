package core.scene.cpu 
{
	import core.scene.MapModel;
	import core.scene.SanguoCamera;
	import flash.display.Shape;
	import global.ModelEntry;
	import global.SanguoEntry;
	import rookie.core.render.cpu.RichSprite;
	import rookie.tool.common.Color;
	import rookie.tool.math.RookieMath;
	import rookie.tool.namer.namer;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MapDebugLayerCpu extends RichSprite
	{
		private var _mapModel:MapModel;
		private var _camera:SanguoCamera;
		//水平
		private var _numCellW:int;
		//竖直
		private var _numCellH:int;
		private var _cells:Vector.<MapDebugCell> = new Vector.<MapDebugCell>();
		
		public function MapDebugLayerCpu() 
		{
			_mapModel = ModelEntry.mapModel;
			_camera = SanguoEntry.camera;
		}
		
		public function render():void
		{
			if (_mapModel.curMapVO)
			{
				var blockStartIndexX:int = getBlockStartIndex(_camera.xInScene);
				var blockStartIndexY:int = getBlockStartIndex(_camera.yInScene);
				var startX:Number = blockStartIndexX * MapModel.MAP_BLOCK_SIZE;
				var startY:Number = blockStartIndexY * MapModel.MAP_BLOCK_SIZE;
				for (var j:int = 0; j < _numCellH; j++)
				{
					for (var i:int = 0; i < _numCellW; i++)
					{
						var cell:MapDebugCell = _cells[i + j * _numCellW];
						cell.x = i * MapModel.CELL_WIDTH + startX;
						cell.y = j * MapModel.CELL_HEIGHT + startY;
						//cell.synTxt();
						cell.synObstacle();
					}
				}
			}
		}
		
		public function onScreenResize():void
		{
			_numCellW = getBlockNum(_camera.width) * (MapModel.MAP_BLOCK_SIZE / MapModel.CELL_WIDTH);
			_numCellH = getBlockNum(_camera.height) * (MapModel.MAP_BLOCK_SIZE / MapModel.CELL_HEIGHT);
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
		
		/**
		 * 获得第一个地图块的纵向/横向索引
		 */
		private function getBlockStartIndex(coord:Number):int
		{
			var index:int = RookieMath.floor(coord / MapModel.MAP_BLOCK_SIZE) - MapModel.CAMERA_RESERVE_BLOCK_NUM;
			if (index < 0)
			{
				index = 0;
			}
			return index;
		}
		
		/**
		 * 获得一定范围内需要的纵向/横向地图块叔
		 */
		private function getBlockNum(distance:Number):int
		{
			return RookieMath.ceil(distance / MapModel.MAP_BLOCK_SIZE) + MapModel.CAMERA_RESERVE_BLOCK_NUM * 2;
		}
	}
}

import flash.display.Shape;
import flash.geom.Point;
import flash.text.TextField;
import global.ModelEntry;
import rookie.core.render.cpu.RichSprite;
import rookie.tool.common.Color;
import rookie.tool.text.RookieTextField;
import rookie.tool.text.TextTool;
import core.scene.MapModel;
import tool.CoorTool;

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
		_shape.graphics.drawRect(0, 0, MapModel.CELL_WIDTH, MapModel.CELL_HEIGHT);
		_shape.graphics.endFill();
		addChild(_shape);
		
		_obstacle = new Shape();
		_obstacle.graphics.beginFill(Color.BLACK_DATA);
		_obstacle.graphics.drawCircle(MapModel.CELL_WIDTH * 0.5, MapModel.CELL_HEIGHT * 0.5, 10);
		_obstacle.graphics.endFill();
		_obstacle.visible = false;
		addChild(_obstacle);
	}
	
	public function synTxt():void
	{
		var pt:Point = CoorTool.sceneToCell(this.x, this.y);
		_txt.htmlText = TextTool.getHtmlText("(" + pt.x + "," + pt.y + ")");
	}
	
	public function synObstacle():void
	{
		var pt:Point = CoorTool.sceneToCell(this.x, this.y);
		_obstacle.visible = ModelEntry.mapModel.curMapVO.getCellType(pt.x, pt.y) > 0;
	}
}