package core 
{
	import com.greensock.TweenNano;
	import config.ZingConfig;
	import config.ZingStageVO;
	import define.ZingPathVO;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import tool.ZingAlignTool;
	import tool.getZingBmd;
	import tool.ZingMathTool;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingScene extends Sprite 
	{
		private var _bg:Bitmap;
		private var _grid:Bitmap;
		private var _hint:Bitmap;
		//
		private var _cellRef:Vector.<ZingCell>;
		private var _cellLayer:Sprite;
		//
		private var _pathRef:Vector.<ZingPathEle>;
		private var _pathLayer:Sprite;
		//
		private var _animLayer:Sprite;
		
		public function ZingScene() 
		{
			_bg = new Bitmap();
			addChild(_bg);
			
			_grid = new Bitmap();
			_grid.y = 200;
			//_grid.alpha = 0.6;
			addChild(_grid);
			
			_cellRef = new Vector.<ZingCell>();
			_cellLayer = new Sprite();
			_cellLayer.y = 200;
			addChild(_cellLayer);
			
			_pathRef = new Vector.<ZingPathEle>();
			_pathLayer = new Sprite();
			_pathLayer.y = _cellLayer.y;
			_pathLayer.mouseEnabled = false;
			_pathLayer.mouseChildren = false;
			addChild(_pathLayer);
			
			_animLayer = new Sprite();
			_animLayer.mouseEnabled = false;
			_animLayer.mouseChildren = false;
			addChild(_animLayer);
			
			_hint = new Bitmap();
			addChild(_hint);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			if (ZingConfig.DEBUG_MODE)
			{
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
		}
		
		public function init():void
		{
			initBg();
			initCellLayer();
			initPathLayer();
			initAnimLayer();
		}
		
		private function initBg():void
		{
			var vo:ZingStageVO = ZingEntry.zingModel.getCurStageVO();
			_bg.bitmapData = getZingBmd("bg" + vo.bg);
			_grid.bitmapData = getZingBmd("grid" + vo.grid);
			if (vo.hint)
			{
				_hint.alpha = 1;
				_hint.bitmapData = getZingBmd("hint" + vo.hint);
				_hint.x = 130;
				_hint.y = 320;
				TweenNano.to(_hint, 0.6, { alpha: 0.3, onComplete:function():void
				{
					TweenNano.to(_hint, 0.6, { alpha: 0.8, onComplete:function():void
					{
						TweenNano.to(_hint, 0.4, { alpha: 0, onComplete:function():void
						{
							_hint.visible = false;
							_hint.alpha = 1;
						}});
					}});
				}});
			}
			else
			{
				_hint.bitmapData = null;
			}
			//ZingAlignTool.alignToCenter(_grid);
		}
		
		private function initCellLayer():void
		{
			//待优化
			_cellLayer.removeChildren();
			_cellRef.length = 0;
			
			var vo:ZingStageVO = ZingEntry.zingModel.getCurStageVO();
			var numCell:int = vo.data.length;
			var w:int = vo.width;
			var h:int = vo.height; 
			for (var i:int = 0; i < numCell; i++)
			{
				var cell:ZingCell = new ZingCell();
				cell.index = i;
				var logicX:int = i % w;
				var logicY:int = i / w;
				cell.setlogicPos(logicX, logicY);
				cell.x = logicX * ZingConfig.CELL_WIDTH;
				cell.y = logicY * ZingConfig.CELL_HEIGHT;
				var type:int = vo.getEleTypeAt(logicX, logicY);
				cell.init(type);
				_cellRef.push(cell);
				_cellLayer.addChild(cell);
			}
			
			//ZingAlignTool.alignToCenter(_cellLayer);
		}
		
		private function initPathLayer():void
		{
			//ZingAlignTool.alignTo(_pathLayer, _cellLayer);
			resetPathLayer();
		}
		
		public function initAnimLayer():void
		{
			_animLayer.removeChildren();
		}
		
		public function resetPathLayer():void
		{
			_pathLayer.removeChildren();
			_pathRef.length = 0;
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			var tgtCell:ZingCell = e.target as ZingCell;
			if (tgtCell)
			{
				trace("MouseDown!");
				ZingEntry.zingLogic.drawStart();
				ZingEntry.zingLogic.tryAddToPath(tgtCell);
			}
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			if (ZingEntry.zingLogic.isDrawing)
			{
				ZingEntry.zingLogic.drawEnd();
			}
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			var tgtCell:ZingCell = e.target as ZingCell;
			if (ZingEntry.zingLogic.isDrawing && tgtCell)
			{
				if (ZingMathTool.isInCellResponse(e.stageX, e.stageY, tgtCell))
				{
					trace("MouseMove!");
					ZingEntry.zingLogic.tryAddToPath(tgtCell);
				}
			}
		}
		
		public function drawPath(pt:Point):void
		{
			trace("draw path at" + pt + "!");
			var pathEle:ZingPathEle = new ZingPathEle();
			pathEle.x = (pt.x + 0.5) * ZingConfig.CELL_WIDTH;
			pathEle.y = (pt.y + 0.5) * ZingConfig.CELL_HEIGHT;
			_pathRef.push(pathEle);
			_pathLayer.addChild(pathEle);
			
			//路径数据
			var path:Vector.<Point> = ZingEntry.zingModel.path;
			
			//刷新这一格
			var length:int = path.length;
			var startIndex:int = length - 2;
			if (startIndex < 0)
			{
				startIndex = 0;
			}
			var part:Vector.<Point> = path.slice(startIndex);
			var pt1:Point;
			var pt2:Point;
			var pt3:Point;
			if (part.length == 2)
			{
				pt1 = part[0];
				pt2 = part[1];
				pt3 = null;
			}
			else if (part.length == 1)
			{
				pt1 = null;
				pt2 = part[0];
				pt3 = null;
			}
			var vo:ZingPathVO = ZingMathTool.getPathVO(pt1, pt2, pt3);
			pathEle.setSource(vo);
			
			//刷新上一格
			if (length > 1)
			{
				startIndex --;
				if (startIndex < 0)
				{
					startIndex = 0;
				}
				part = path.slice(startIndex, startIndex + 3);
				if (part.length == 3)
				{
					pt1 = part[0];
					pt2 = part[1];
					pt3 = part[2];
				}
				else if (part.length == 2)
				{
					pt1 = null;
					pt2 = part[0];
					pt3 = part[1];
				}
				vo = ZingMathTool.getPathVO(pt1, pt2, pt3);
				pathEle = _pathRef[length - 2];
				pathEle.setSource(vo);
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.LEFT:
					ZingEntry.zingModel.stage --;
					if (ZingEntry.zingModel.getCurStageVO())
					{
						init();
						ZingEntry.zingGUI.syn();
					}
					else
					{
						ZingEntry.zingModel.stage ++;
					}
					break;
				case Keyboard.RIGHT:
					ZingEntry.zingModel.stage ++;
					if (ZingEntry.zingModel.getCurStageVO())
					{
						init();
						ZingEntry.zingGUI.syn();
					}
					else
					{
						ZingEntry.zingModel.stage --;
					}
					break;
			}
		}
		
		public function get animLayer():Sprite
		{
			return _animLayer;
		}
		
		public function get cellLayer():Sprite
		{
			return _cellLayer;
		}
	}
}