package rookie.core.time
{
	import rookie.core.IMainLoop;

	import flash.utils.getTimer;

	/**
	 * @author Warmly
	 */
	public class TimerManager implements IMainLoop
	{
		private var _timeOutVec : Vector.<TimerVO>;
		private var _timeIntervalVec : Vector.<TimerVO>;

		public function TimerManager()
		{
			_timeOutVec = new Vector.<TimerVO>();
			_timeIntervalVec = new Vector.<TimerVO>();
		}

		/**
		 * @param time(ms)    总时间
		 */
		public function setTimeOut(time : uint, callBack : Function, ...args) : TimerVO
		{
			if (time == 0)
			{
				callBack.apply(callBack, args);
				return null;
			}
			var t : int = getTimer();
			var timerVO : TimerVO = new TimerVO();
			timerVO.outTime = t + time;
			timerVO.fun = callBack;
			timerVO.args = args;
			_timeOutVec.push(timerVO);
			return timerVO;
		}

		/**
		 * @param executeImmediately 是否调用时立即执行一次
		 * @param interval(ms)       间隔
		 * @param time(ms)           总时间
		 */
		public function setInterval(interval : uint, time : uint, executeImmediately : Boolean, intervalFun : Function, ...args) : TimerVO
		{
			if (time == 0)
			{
				intervalFun.apply(intervalFun, args);
				return null;
			}
			if (executeImmediately)
			{
				intervalFun.apply(intervalFun, args);
			}
			var t : int = getTimer();
			var timerVO : TimerVO = new TimerVO();
			timerVO.intervalTime = interval;
			timerVO.outTime = t + time;
			timerVO.curOutTime = t + interval;
			timerVO.fun = intervalFun;
			timerVO.args = args;
			_timeIntervalVec.push(timerVO);
			return timerVO;
		}

		public function onEnterFrame() : void
		{
			handleTimeOut();
			handleTimeInterval();
		}

		private function handleTimeOut() : void
		{
			var curTime : int = getTimer();
			var num : int = _timeOutVec.length;
			var timerVO : TimerVO;
			var needFilterNull : Boolean;
			for (var i : int = 0;i < num;i++)
			{
				if (i < _timeOutVec.length)
				{
					timerVO = _timeOutVec[i];
					if (timerVO && curTime >= timerVO.outTime)
					{
						timerVO.fun.apply(timerVO.fun, timerVO.args);
						if (i < _timeOutVec.length)
				        {
							_timeOutVec[i] = null;
						}
						needFilterNull = true;
					}
				}
			}
			if (needFilterNull)
			{
				_timeOutVec = _timeOutVec.filter(filterNull);
			}
		}

		private function handleTimeInterval() : void
		{
			var curTime : int = getTimer();
			var num : int = _timeIntervalVec.length;
			var timerVO : TimerVO;
			var needFilterNull : Boolean;
			for (var i : int = 0;i < num;i++)
			{
				timerVO = _timeIntervalVec[i];
				if (timerVO && curTime >= timerVO.outTime)
				{
					timerVO.fun.apply(timerVO.fun, timerVO.args);
					_timeIntervalVec[i] = null;
					needFilterNull = true;
				}
				else if (curTime >= timerVO.curOutTime)
				{
					timerVO.fun.apply(timerVO.fun, timerVO.args);
					timerVO.curOutTime += timerVO.intervalTime;
				}
			}
			if (needFilterNull)
			{
				_timeIntervalVec = _timeIntervalVec.filter(filterNull);
			}
		}

		private function filterNull(item : TimerVO, index : int, vec : Vector.<TimerVO>) : Boolean
		{
			return item != null;
		}
		
		public function clearAllTimer():void
		{
			_timeIntervalVec.length = 0;
			_timeOutVec.length = 0;
		}
	}
}
