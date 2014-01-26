package core 
{
	import config.ZingStageVO;
	import define.ZingEleEnum;
	import define.ZingSoundEnum;
	import flash.geom.Point;
	import rookie.global.RookieEntry;
	import rookie.tool.math.RookieMath;
	import rookie.tool.functionHandler.FH;
	import tool.ZingMathTool;
	import tool.ZingSoundTool;
	
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
			_isDrawing = false;
			ZingEntry.zingModel.path.length = 0;
			var curStage:int = ZingEntry.zingModel.stage;
			var vo:ZingStageVO = ZingEntry.zingConfig.getStageVO(curStage + 1);
			if (vo)
			{
				ZingSoundTool.playSoundEff(ZingSoundEnum.PASS);
			}
			RookieEntry.timerManager.setTimeOut(300, function():void
			{
				if (vo)
				{
					ZingEntry.zingModel.stage ++;
					ZingEntry.zingScene.resetPathLayer();
					nextStage();
				}
				else
				{
					gameEnd();
				}
			});
		}
		
		public function drawFail():void
		{
			_isDrawing = false;
			ZingEntry.zingModel.path.length = 0;
			RookieEntry.timerManager.setTimeOut(300, function():void
			{
				ZingEntry.zingScene.init();
				ZingEntry.zingModel.life --;
				if (ZingEntry.zingModel.life == 0)
				{
					gameEnd();
				}
			});
		}
		
		private function nextStage():void
		{
			ZingEntry.zingScene.init();
			ZingEntry.zingGUI.init();
		}
		
		public function gameStart():void
		{
			ZingEntry.zingModel.init();
			ZingEntry.zingScene.init();
			ZingEntry.zingGUI.init();
			ZingEntry.zingCover.visible = false;
			startClock();
		}
		
		public function gameEnd():void
		{
			ZingEntry.zingGUI.init();
			ZingEntry.zingGUI.popOverBoard();
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
						check(cell);
					}
				}
			}
			else
			{
				addToPath(pt);
				check(cell);
			}
		}
		
		private function tryClearCellEle(cell:ZingCell):void
		{
			if (cell.type != ZingEleEnum.TARGET && cell.type != ZingEleEnum.EMPTY)
			{
				cell.clear();
			}
		}
		
		private function addToPath(pt:Point):void
		{
			var path:Vector.<Point> = ZingEntry.zingModel.path;
			path.push(pt);
			ZingEntry.zingScene.drawPath(pt);
		}
		
		private function check(cell:ZingCell):void
		{
			if (hasDrawAllTgt())
			{
				drawSuccess();
				return;
			}
			var type:int = cell.type;
			if (isCross())
			{
				cell.addAnimEff(ZingEleEnum.BOMB);
				cell.addSoundEff(10);
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
						cell.addSoundEff(ZingEleEnum.TARGET);
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
			tryClearCellEle(cell);
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