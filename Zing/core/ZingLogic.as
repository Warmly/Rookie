package core 
{
	import config.ZingStageVO;
	import flash.geom.Point;
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
			ZingEntry.zingModel.path.length = 0;
			ZingEntry.zingScene.resetPathLayer();
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
		}
		
		public function drawFail():void
		{
			ZingEntry.zingModel.life --;
			if (ZingEntry.zingModel.life == 0)
			{
				gameEnd();
			}
		}
		
		public function gameEnd():void
		{
		}
		
		public function get isDrawing():Boolean
		{
			return _isDrawing;
		}
		
		public function isInPath(x:int, y:int):Boolean
		{
			var pt:Point = new Point(x, y);
			var path:Vector.<Point> = ZingEntry.zingModel.path;
			for each(var i:Point in path)
			{
				if (ptEqual(i, pt))
				{
					return true;
				}
			}
			return false;
		}
		
		public function addToPath(x:int, y:int):void
		{
			var pt:Point = new Point(x, y);
			var path:Vector.<Point> = ZingEntry.zingModel.path;
			var num:int = path.length;
			//第一个点或者不是上一个点
			if (num == 0 || !ptEqual(pt, path[num - 1]))
			{
				//与之前的路径交叉
				if (isInPath(x, y))
				{
					drawFail();
					return;
				}
				path.push(pt);
				ZingEntry.zingScene.drawPath(pt);
			}
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
					if (ptEqual(i, j))
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
		
		private function ptEqual(pt1:Point, pt2:Point):Boolean
		{
			return pt1.x == pt2.x && pt1.y == pt2.y;
		}
	}
}