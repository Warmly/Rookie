package core 
{
	import config.ZingStageVO;
	import flash.geom.Point;
	import rookie.tool.math.RookieMath;
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
			_isDrawing = false;
			if (hasDrawAllTgt())
			{
				drawSuccess();
			}
			else
			{
				drawFail();
			}
			ZingEntry.zingModel.path.length = 0;
			ZingEntry.zingScene.resetPathLayer();
		}
		
		public function drawSuccess():void
		{
			trace("Success!");
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
			ZingEntry.zingModel.stage = 1;
			ZingEntry.zingScene.init();
			ZingEntry.zingGUI.visible = false;
		}
		
		public function gameEnd():void
		{
			trace("GameEnd!");
			ZingEntry.zingGUI.visible = true;
		}
		
		public function get isDrawing():Boolean
		{
			return _isDrawing;
		}
		
		private function isInPath(pt:Point):Boolean
		{
			var path:Vector.<Point> = ZingEntry.zingModel.path;
			for each(var i:Point in path)
			{
				if (ZingMathTool.isEqualPt(i, pt))
				{
					return true;
				}
			}
			return false;
		}
		
		public function tryAddToPath(x:int, y:int):void
		{
			var pt:Point = new Point(x, y);
			var path:Vector.<Point> = ZingEntry.zingModel.path;
			var num:int = path.length;
			if (num != 0)
			{
				var lastPt:Point = path[num - 1];
				if (!ZingMathTool.isEqualPt(pt, lastPt))
				{
					//与之前的路径交叉
					if (isInPath(pt))
					{
						drawFail();
						return;
					}
					if (ZingMathTool.isNeighbourPt(pt, lastPt))
					{
						addToPath(pt);
					}
				}
			}
			else
			{
				addToPath(pt);
			}
		}
		
		private function addToPath(pt:Point):void
		{
			var path:Vector.<Point> = ZingEntry.zingModel.path;
			path.push(pt);
			ZingEntry.zingScene.drawPath(pt);
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