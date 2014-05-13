package rookie.core.time
{
	import flash.utils.Dictionary;
	import rookie.core.IMainLoop;
	import rookie.dataStruct.HashTable;
	import rookie.tool.functionHandler.FunHandler;
	import rookie.tool.log.error;
	import rookie.tool.namer.namer;
	
	import flash.utils.getTimer;
	
	/**
	 * 计时器管理
	 * @author Warmly
	 */
	public class TimerManager implements IMainLoop
	{
		private var _timeOutTable:HashTable = new HashTable(String, TimerVO); 
		private var _timeIntervalTable:HashTable = new HashTable(String, TimerVO);
		
		public function TimerManager()
		{
			_timeOutTable.name = namer("TimerManager", "_timeOutTable");
			_timeIntervalTable.name = namer("TimerManager", "_timeIntervalTable");
		}
		
		/**
		 * @param time(ms)    总时间
		 * @param name        键名称，最好用全局函数namer生成
		 */
		public function setTimeOut(time:Number, name:String, outFun:FunHandler):TimerVO
		{
			var t:Number = getTimer();
			var vo:TimerVO = new TimerVO();
			vo.outTime = t + time;
			vo.name = name;
			vo.outFun = outFun;
			_timeOutTable.insert(name, vo);
			return vo;
		}
		
		public function clearTimeOut(vo:TimerVO):void
		{
			_timeOutTable.del(vo.name);
		}
		
		/**
		 * @param interval(ms)       间隔
		 * @param time(ms)           总时间(默认小于0为无限循环)
		 * @param name               键名称，最好用全局函数namer生成
		 * @param executeImmediately 是否调用时立即执行一次
		 */
		public function setInterval(interval:Number, time:Number, name:String, executeImmediately:Boolean, intervalFun:FunHandler, outFun:FunHandler):TimerVO
		{
			if (interval == 0)
			{
				error("Invalid timer interval!");
				return null;
			}
			if (executeImmediately)
			{
				intervalFun.execute();
			}
			var t:Number = getTimer();
			var vo:TimerVO = new TimerVO();
			vo.intervalTime = interval;
			vo.outTime = t + time;
			vo.curOutTime = t + interval;
			vo.name = name;
			vo.intervalFun = intervalFun;
			vo.outFun = outFun;
			_timeIntervalTable.insert(name, vo);
			return vo;
		}
		
		public function cleatTimeInterval(vo:TimerVO):void
		{
			_timeIntervalTable.del(vo.name);
		}
		
		public function onEnterFrame():void
		{
			handleTimeOut();
			handleTimeInterval();
		}
		
		private function handleTimeOut():void
		{
			var curTime:Number = getTimer();
			var items:Dictionary = _timeOutTable.content;
			for each (var item:TimerVO in items) 
			{
				if (curTime >= item.outTime)
				{
					if (item.outFun)
					{
						item.outFun.execute();
					}
					clearTimeOut(item);
				}
			}
		}
		
		private function handleTimeInterval():void
		{
			var curTime:Number = getTimer();			
			var items:Dictionary = _timeIntervalTable.content;
			for each (var item: TimerVO in items) 
			{
				if (item.outTime >= 0 && curTime >= item.outTime)
				{
					if (item.outFun)
					{
						item.outFun.execute();
					}
					cleatTimeInterval(item);
				}
				else if (curTime >= item.curOutTime)
				{
					if (item.intervalFun)
					{
						item.intervalFun.execute();
					}
					item.curOutTime += item.intervalTime;
				}
			}
		}
	}
}
