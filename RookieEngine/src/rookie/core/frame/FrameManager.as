package rookie.core.frame 
{
	import flash.utils.Dictionary;
	import rookie.dataStruct.HashTable;
	import rookie.tool.functionHandler.FunHandler;
	
	/**
	 * 帧事务管理器
	 * @author Warmly
	 */
	public class FrameManager 
	{
		private var _frameOutTable:HashTable = new HashTable(String, FrameVO);
		private var _frameIntervalTable:HashTable = new HashTable(String, FrameVO);
		
		public function FrameManager() 
		{
		}
		
		/**
		 * @param frame    总帧数
		 * @param name     键名称，用全局函数namer生成
		 */
		public function setFrameOut(frame:uint, name:String, outFun:FunHandler):FrameVO
		{
			if (frame == 0)
			{
				outFun.execute();
				return null;
			}
			var vo:FrameVO = new FrameVO();
			vo.outFrame = frame;
			vo.name = name;
			vo.outFun = outFun;
			_frameOutTable.insert(name, vo);
			return vo;
		}
		
		public function clearFrameOut(vo:FrameVO):void
		{
			_frameOutTable.del(vo);
		}
		
		/**
		 * @param interval 间隔帧数
		 * @param frame    总帧数
		 * @param name     键名称，用全局函数namer生成
		 * @param executeImmediately 是否调用时立即执行一次
		 */
		public function setFrameInterval(interval:uint, frame:uint, name:String, executeImmediately:Boolean, intervalFun:FunHandler, outFun:FunHandler):FrameVO
		{
			if (frame == 0)
			{
				outFun.execute();
			}
			if (executeImmediately)
			{
				intervalFun.execute();
			}
			var vo:FrameVO = new FrameVO();
			vo.intervalFrame = interval;
			vo.outFrame = frame;
			vo.curOutFrame = interval;
			vo.name = name;
			vo.intervalFun = intervalFun;
			vo.outFun = outFun;
			_frameIntervalTable.insert(name, vo);
			return vo;
		}
		
		public function clearFrameInterval(vo:FrameVO):void
		{
			_frameIntervalTable.del(vo);
		}
		
		public function onEnterFrame():void
		{
			handleFrameOut();
			handleFrameInterval();
		}
		
		private function handleFrameOut():void 
		{
			var items:Dictionary = _frameOutTable.content;
			for each (var item:FrameVO in items) 
			{
				item.passedFrame ++;
				if (item.passedFrame >= item.outFrame)
				{
					item.outFun.execute();
					clearFrameOut(item);
				}
			}
		}
		
		private function handleFrameInterval():void 
		{
			var items:Dictionary = _frameIntervalTable.content;
			for each (var item:FrameVO in items) 
			{
				item.passedFrame ++;
				if (item.passedFrame >= item.outFrame)
				{
					item.outFun.execute();
					clearFrameInterval(item);
				}
				else if (item.passedFrame >= item.curOutFrame)
				{
					item.intervalFun.execute();
					item.curOutFrame += item.intervalFrame;
				}
			}
		}
	}
}