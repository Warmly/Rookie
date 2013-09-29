package rookie.core.render
{
	import rookie.core.resource.ResUrl;
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;

	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class AnimCpu extends ImgCpuBase implements IRenderItem
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
		// 开始帧
		private var _startFrame:uint;
		// 结束帧
		private var _endFrame:uint;

		public function AnimCpu(resUrl:ResUrl)
		{
			super(resUrl);
			_curFrame = 1;
			_frequency = _DEFAULT_FREQUENCY;
			_intervalTime = 1000 / _frequency;
			_totalFrame = _imgConfigVO.frameLength;
			setPlayRange(1, _totalFrame);
			gotoAndPlay(_startFrame);
		}

		private function enterFrameRender():void
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
				if (_curFrame < _endFrame)
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
			if (curFrameVO.bitmapData)
			{
				var curRect:Rectangle = curFrameVO.validRect;
				var maxWidth:uint = _imgConfigVO.imgWidth;
				var maxHeight:uint = _imgConfigVO.imgHeight;
				var offsetX:Number = (maxWidth - curRect.width) * 0.5;
				var offsetY:Number = (maxHeight - curRect.height) * 0.5;
				super.x = _originX + offsetX;
				super.y = _originY + offsetY;
				super.bitmapData = curFrameVO.bitmapData;
			}
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
			_lastTime = getTimer();
			_curFrame = frame;
			startPlay();
		}

		public function startPlay():void
		{
			RookieEntry.renderManager.addToQueue(this);
		}

		public function stopPlay():void
		{
			dispose();
			deleteParent();
			_curLoop = 1;
		}

		public function render():void
		{
			enterFrameRender();
		}

		public function dispose():void
		{
			RookieEntry.renderManager.dispose(this);
		}

		public function get key():String
		{
			return _resUrl.url + name;
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
