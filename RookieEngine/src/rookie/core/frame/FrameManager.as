package rookie.core.frame 
{
	import flash.utils.Dictionary;
	import rookie.core.IMainLoop;
	import rookie.dataStruct.HashTable;
	import rookie.tool.functionHandler.FunHandler;
	import rookie.tool.log.error;
	import rookie.tool.namer.namer;
	
	/**
	 * 帧事务管理器
	 * @author Warmly
	 */
	public class FrameManager implements IMainLoop
	{
		private var _frameOutTable:HashTable = new HashTable(String, FrameVO);
		private var _frameIntervalTable:HashTable = new HashTable(String, FrameVO);
		
		public function FrameManager() 
		{
			_frameOutTable.name = namer("FrameManager","_frameOutTable");
			_frameIntervalTable.name = namer("FrameManager","_frameIntervalTable");
		}
		
		/**
		 * @param frame    总帧数
		 * @param name     键名称，用全局函数namer生成
		 */
		public function setFrameOut(frame:uint, name:String, outFun:FunHandler):FrameVO
		{
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
		 * @param frame    总帧数(默认小于0为无限循环)
		 * @param name     键名称，用全局函数namer生成
		 * @param executeImmediately 是否调用时立即执行一次
		 */
		public function setFrameInterval(interval:uint, frame:int, name:String, executeImmediately:Boolean, intervalFun:FunHandler, outFun:FunHandler = null):FrameVO
		{
			if (interval == 0)
			{
				error("Invalid frame interval!");
				return null; 
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
				if (item.outFrame >= 0 && item.passedFrame >= item.outFrame)
				{
					if (item.outFun)
					{
						item.outFun.execute();
					}
					clearFrameInterval(item);
				}
				else if (item.passedFrame >= item.curOutFrame)
				{
					if (item.intervalFun)
					{
						item.intervalFun.execute();
					}
					item.curOutFrame += item.intervalFrame;
				}
			}
		}
	}
}