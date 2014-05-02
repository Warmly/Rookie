package rookie.core.render.cpu
{
	import rookie.core.render.IRenderItem;
	import rookie.core.resource.ResUrl;
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.global.RookieEntry;
	import rookie.tool.functionHandler.FunHandler;
	import flash.utils.getTimer;
	/**
	 * @author Warmly
	 */
	public class AnimCpu extends ImgCpuBase implements IRenderItem
	{
		protected static const _DEFAULT_FREQUENCY:Number = 8;
		protected var _totalFrame:uint;
		protected var _curFrame:uint;
		// 频率：帧/秒
		protected var _frequency:Number;
		// 当前帧时间
		protected var _curTime:Number;
		// 上一帧时间
		protected var _lastTime:Number;
		// 间隔时间
		protected var _intervalTime:Number;
		// 播放次数，默认一直播放
		protected var _loop:int = -1;
		protected var _curLoop:int = 0;
		protected var _loopEndCallBack:FunHandler;
		// 基准点
		protected var _originX:Number = 0;
		protected var _originY:Number = 0;
		// 开始帧
		protected var _startFrame:uint;
		// 结束帧
		protected var _endFrame:uint;
		// 当前帧数据
		protected var _curFrameVO:ImgFrameConfigVO;

		public function AnimCpu(resUrl:ResUrl, isAutoPlay:Boolean = true)
		{
			super(resUrl);
			_curFrame = 1;
			_frequency = _DEFAULT_FREQUENCY;
			_intervalTime = 1000 / _frequency;
			if (_imgConfigVO)
			{
				_totalFrame = _imgConfigVO.frameLength;
			}
			setPlayRange(1, _totalFrame);
			if (isAutoPlay)
			{
				gotoAndPlay(_startFrame);
			}
		}

		private function enterFrameRender():void
		{
			_curTime = getTimer();
			if (_curTime - _lastTime >= _intervalTime)
			{
				setCurFrameBmd();
				_lastTime = _curTime;
				if (_curFrame < _endFrame)
				{
					_curFrame++;
				}
				else
				{
					_curLoop++;
					_curFrame = _startFrame;
				}
				if (_curLoop == _loop)
				{
					stopPlay();
					if (_loopEndCallBack)
					{
						_loopEndCallBack.execute();
					}
					return;
				}
			}
		}

		protected function setCurFrameBmd():void
		{
			_curFrameVO = _imgConfigVO.getFrames(_curFrame - 1);
			if (_curFrameVO)
			{
				super.bitmapData = _curFrameVO.bitmapData;
				adjustInnerPos();
			}
		}

		protected function adjustInnerPos():void
		{
			super.x = _originX + _curFrameVO.validRectX;
			super.y = _originY + _curFrameVO.validRectY;
		}

		public function setPlayRange(start:uint, end:uint):void
		{
			_startFrame = start;
			_endFrame = end;
		}

		override public function set x(value:Number):void
		{
			_originX = value;
		}

		override public function set y(value:Number):void
		{
			_originY = value;
		}

		public function gotoAndPlay(frame:int):void
		{
			_curFrame = frame;
			startPlay();
			setCurFrameBmd();
		}

		public function startPlay():void
		{
			_lastTime = getTimer();
			RookieEntry.renderManager.addToQueue(this);
		}

		public function stopPlay():void
		{
			dispose();
			//deleteParent();
			_curLoop = 0;
		}

		protected function hardSetPos(xValue:Number, yValue:Number):void
		{
			super.x = xValue;
			super.y = yValue;
		}

		public function render():void
		{
			enterFrameRender();
		}

		public function dispose():void
		{
			RookieEntry.renderManager.removeFromQueue(this);
		}

		public function get key():String
		{
			return _resUrl.url + "[" + name + "]";
		}

		public function get loop():uint
		{
			return _loop;
		}

		public function set loop(loop:uint):void
		{
			_loop = loop;
		}
		
		public function set frequency(val:Number):void
		{
			_frequency = val;
			_intervalTime = 1000 / _frequency;
		}
		
		public function get loopEndCallBack():FunHandler 
		{
			return _loopEndCallBack;
		}
		
		public function set loopEndCallBack(value:FunHandler):void 
		{
			_loopEndCallBack = value;
		}
	}
}
