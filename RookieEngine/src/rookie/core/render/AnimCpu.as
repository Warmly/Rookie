package rookie.core.render
{
	import flash.geom.Rectangle;

	import rookie.core.vo.ImgFrameConfigVO;

	import flash.utils.getTimer;
	import flash.events.Event;

	import rookie.core.resource.ResUrl;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author Warmly
	 */
	public class AnimCpu extends ImgCpuBase
	{
		private static const _DEFAULT_FREQUENCY:Number = 8;
		private var _totalFrame:uint;
		private var _curFrame:uint;
		// 频率：帧/秒
		private var _frequency:Number;
		// 当前帧时间
		private var _curTime:Number;
		// 上一帧时间
		private var _lastTime:Number;
		// 间隔时间
		private var _intervalTime:Number;
		// 播放次数，默认一直播放
		private var _loop:int = -1;
		private var _curLoop:int = 1;
		// 基准点
		private var _originX:Number;
		private var _originY:Number;

		public function AnimCpu(resUrl:ResUrl, parent:DisplayObjectContainer = null)
		{
			super(resUrl, parent);
			_totalFrame = _imgConfigVO.frameLength;
			_curFrame = 1;
			_frequency = _DEFAULT_FREQUENCY;
			_intervalTime = 1000 / _frequency;
		}

		private function gotoAndPlay(frame:int):void
		{
			_curFrame = frame;
			startPlay();
		}

		private function startPlay():void
		{
			if (!hasEventListener(Event.ENTER_FRAME))
			{
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			_lastTime = getTimer();
		}

		private function stopPlay():void
		{
			if (hasEventListener(Event.ENTER_FRAME))
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			_curLoop = 1;
		}

		private function onEnterFrame(event:Event):void
		{
			_curTime = getTimer();
			if (_curTime - _lastTime >= _intervalTime)
			{
				setCurFrameBmd();
				if (_curLoop == _loop)
				{
					stopPlay();
					return;
				}
				_lastTime = _curTime;
				if (_curFrame < _totalFrame)
				{
					_curFrame++;
				}
				else
				{
					_curLoop++;
					_curFrame = 1;
				}
			}
		}

		private function setCurFrameBmd():void
		{
			var curFrameVO:ImgFrameConfigVO = _imgConfigVO.getFrames(_curFrame - 1);
			var curRect:Rectangle = curFrameVO.validRect;
			var maxWidth:uint = _imgConfigVO.imgWidth;
			var maxHeight:uint = _imgConfigVO.imgHeight;
			var offsetX:Number = (maxWidth - curRect.width) * 0.5;
			var offsetY:Number = (maxHeight - curRect.height) * 0.5;
			super.x = _originX + offsetX;
			super.y = _originY + offsetY;
			super.bitmapData = curFrameVO.bitmapData;
		}

		override public function set x(value:Number):void
		{
			_originX = value;
		}

		override public function set y(value:Number):void
		{
			_originY = value;
		}

		override protected function onImgDataLoaded():void
		{
			super.onImgDataLoaded();
			gotoAndPlay(1);
		}

		public function get loop():uint
		{
			return _loop;
		}

		public function set loop(loop:uint):void
		{
			_loop = loop;
		}
	}
}
