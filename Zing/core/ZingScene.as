package core 
{
	import config.ZingConfig;
	import config.ZingStageVO;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import tool.ZingAlign;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingScene extends Sprite 
	{
		private var _bg:Bitmap;
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
			
			_cellRef = new Vector.<ZingCell>();
			_cellLayer = new Sprite();
			addChild(_cellLayer);
			
			_pathRef = new Vector.<ZingPathEle>();
			_pathLayer = new Sprite();
			_pathLayer.mouseEnabled = false;
			_pathLayer.mouseChildren = false;
			addChild(_pathLayer);
			
			_animLayer = new Sprite();
			_animLayer.mouseEnabled = false;
			_animLayer.mouseChildren = false;
			addChild(_animLayer);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		public function init():void
		{
			initBg();
			initCellLayer();
			initPathLayer();
		}
		
		private function initBg():void
		{
			var vo:ZingStageVO = ZingEntry.zingModel.getCurStageVO();
			_bg.bitmapData = getZingBmd("bg"+vo.bg);
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
			
			ZingAlign.alignToCenter(_cellLayer);
		}
		
		private function initPathLayer():void
		{
			ZingAlign.alignTo(_pathLayer, _cellLayer);
			resetPathLayer();
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
				ZingEntry.zingLogic.addToPath(tgtCell.logicX, tgtCell.logicY);
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
				trace("MouseMove!");
				ZingEntry.zingLogic.addToPath(tgtCell.logicX , tgtCell.logicY);
			}
		}
		
		public function drawPath(pt:Point):void
		{
			trace("draw at" + pt + "!");
			var path:ZingPathEle = new ZingPathEle();
			path.x = (pt.x + 0.5) * ZingConfig.CELL_WIDTH;
			path.y = (pt.y + 0.5) * ZingConfig.CELL_HEIGHT;
			_pathRef.push(path);
			_pathLayer.addChild(path);
		}
	}
}