package core 
{
	import config.ZingStageVO;
	import define.ZingEleEnum;
	import flash.geom.Point;
	import rookie.global.RookieEntry;
	import rookie.tool.math.RookieMath;
	import rookie.tool.functionHandler.FH;
	import tool.ZingMathTool;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingLogic 
	{
		private var _isDrawing:Boolean;
		
		public function ZingLogic() 
		{
		}
	    
		public function drawStart():void
		{
			_isDrawing = true;
		}
		
		public function drawEnd():void
		{
			if (hasDrawAllTgt())
			{
				drawSuccess();
			}
			else
			{
				drawFail();
			}
		}
		
		public function drawSuccess():void
		{
			trace("Success!");
			
			_isDrawing = false;
			ZingEntry.zingModel.path.length = 0;
			ZingEntry.zingScene.resetPathLayer();
			
			var curStage:int = ZingEntry.zingModel.stage;
			if (ZingEntry.zingConfig.getStageVO(curStage + 1))
			{
				ZingEntry.zingModel.stage ++;
				nextStage();
			}
			else
			{
				trace("Clear!");
				gameEnd();
			}
		}
		
		public function drawFail():void
		{
			trace("Fail!");
			
			_isDrawing = false;
			ZingEntry.zingModel.path.length = 0;
			ZingEntry.zingScene.resetPathLayer();
			
			ZingEntry.zingModel.life --;
			if (ZingEntry.zingModel.life == 0)
			{
				gameEnd();
			}
		}
		
		private function nextStage():void
		{
			ZingEntry.zingScene.init();
		}
		
		public function gameStart():void
		{
			trace("GameStart!");
			ZingEntry.zingModel.init();
			ZingEntry.zingScene.init();
			ZingEntry.zingGUI.syn();
			ZingEntry.zingCover.visible = false;
			startClock();
		}
		
		public function gameEnd():void
		{
			trace("GameEnd!");
			ZingEntry.zingGUI.popOver();
			RookieEntry.timerManager.clearAllTimer();
		}
		
		public function get isDrawing():Boolean
		{
			return _isDrawing;
		}
		
		public function startClock():void
		{
			RookieEntry.timerManager.setInterval(1000, 1000 * 9999, false, onSecond);
		}
		
		private function onSecond():void
		{
			trace("Interval!");
			ZingEntry.zingModel.clock --;
			ZingEntry.zingGUI.syn();
			if (ZingEntry.zingModel.clock == 0)
			{
				gameEnd();
			}
		}
		
		public function tryAddToPath(cell:ZingCell):void
		{
			//是障碍点
			if (cell.type == ZingEleEnum.OBSTACLE)
			{
				return;
			}
			var pt:Point = new Point(cell.logicX, cell.logicY);
			var path:Vector.<Point> = ZingEntry.zingModel.path;
			var num:int = path.length;
			if (num != 0)
			{
				var lastPt:Point = path[num - 1];
				if (!ZingMathTool.isEqualPt(pt, lastPt))
				{
					if (ZingMathTool.isNeighbourPt(pt, lastPt))
					{
						addToPath(pt);
						RookieEntry.timerManager.setTimeOut(100, function():void
						{
							check(cell.type);
							tryClearCellEle(cell);
						});
					}
				}
			}
			else
			{
				addToPath(pt);
				RookieEntry.timerManager.setTimeOut(100, function():void
				{
					check(cell.type);
					tryClearCellEle(cell);
				});
			}
		}
		
		private function tryClearCellEle(cell:ZingCell):void
		{
			if (cell.type != ZingEleEnum.TARGET)
			{
				cell.init(ZingEleEnum.EMPTY);
			}
		}
		
		private function addToPath(pt:Point):void
		{
			var path:Vector.<Point> = ZingEntry.zingModel.path;
			path.push(pt);
			ZingEntry.zingScene.drawPath(pt);
		}
		
		private function check(type:int):void
		{
			if (isCross())
			{
				drawFail();
			}
			else
			{
				switch(type)
				{
					case ZingEleEnum.EMPTY:
						break;
					case ZingEleEnum.TARGET:
						ZingEntry.zingModel.score += 100;
						break;
					case ZingEleEnum.OBSTACLE:
						break;
					case ZingEleEnum.BOMB:
						drawFail();
						break;
					case ZingEleEnum.BONUS:
						ZingEntry.zingModel.score += 100;
						break;
					case ZingEleEnum.CLOCK:
						ZingEntry.zingModel.clock += 10;
					    break;
				}
				ZingEntry.zingGUI.syn();
			}
			if (hasDrawAllTgt())
			{
				drawSuccess();
			}
		}
		
		private function isCross():Boolean
		{
			var path:Vector.<Point> = ZingEntry.zingModel.path;
			var num:int = path.length;
			if (num <= 1)
			{
				return false;
			}
			var pt:Point = path[num - 1];
			for (var i:int = 0; i < num - 1; i++)
			{
				if (ZingMathTool.isEqualPt(path[i], pt))
				{
					return true;
				}
			}
			return false;
		}
		
		public function hasDrawAllTgt():Boolean
		{
			//待优化
			var vo:ZingStageVO = ZingEntry.zingModel.getCurStageVO();
			var tgt:Vector.<Point> = vo.tgtPtVec;
			var hasDrawVec:Vector.<Point> = ZingEntry.zingModel.path;
			for each(var i:Point in tgt)
			{
				var hasDrawThisPt:Boolean = false;
				for each(var j:Point in hasDrawVec)
				{
					if (ZingMathTool.isEqualPt(i, j))
					{
						hasDrawThisPt = true;
					}
				}
				if (!hasDrawThisPt)
				{
					return false;
				}
			}
			return true;
		}
	}
}