package rookie.core.render.cpu
{
	import definition.SanguoDefine;
	import rookie.core.render.IRenderItem;
	import rookie.core.render.RenderType;
	import rookie.core.resource.ResUrl;
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.dataStruct.HashTable;
	import rookie.global.RookieEntry;
	import rookie.tool.functionHandler.FunHandler;
	import flash.utils.getTimer;
	/**
	 * @author Warmly
	 */
	public class AnimCpu extends ImgCpuBase implements IRenderItem
	{
		protected var _totalFrame:uint;
		protected var _curFrame:uint = 1;
		// 频率：帧/秒
		protected var _frequency:Number;
		// 当前帧时间
		protected var _curTime:Number;
		// 上一帧时间
		protected var _lastTime:Number;
		// 间隔时间(ms)
		protected var _intervalTime:Number;
		// 播放次数，0默认一直播放
		protected var _loop:uint = 0;
		protected var _curLoop:uint = 1;
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
		protected var _isRendering:Boolean;
		// 帧回调
		protected var _frameCallBackTable:HashTable = new HashTable(uint, FunHandler);

		public function AnimCpu(resUrl:ResUrl, isAutoPlay:Boolean = true)
		{
			super(resUrl);
		    frequency = SanguoDefine.NORMAL_ANIM_FREQUENCY;
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
				if (_frameCallBackTable.has(_curFrame))
				{
					var fun:FunHandler = _frameCallBackTable.search(_curFrame) as FunHandler;
					fun.execute();
				}
				_lastTime = _curTime;
				if (_curFrame < _endFrame)
				{
					_curFrame++;
				}
				else
				{
					if (_curLoop != _loop)
					{
						_curLoop++;
						_curFrame = _startFrame;
					}
					else
					{
						stopPlay();
						if (_loopEndCallBack)
						{
							_loopEndCallBack.execute();
						}
					}
				}
			}
		}

		protected function setCurFrameBmd():void
		{
			_curFrameVO = _imgConfigVO.getFrame(_curFrame - 1);
			if (_curFrameVO && _curFrameVO.bitmapData)
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
			if (!_isRendering)
			{
				_lastTime = getTimer();
				RookieEntry.renderManager.addToCpuRenderQueue(this);
				_isRendering = true;
			}
		}

		public function stopPlay():void
		{
			RookieEntry.renderManager.removeFromCpuRenderQueue(this);
			_isRendering = false;
			_curLoop = 1;
		}

		protected function hardSetPos(xValue:Number, yValue:Number):void
		{
			super.x = xValue;
			super.y = yValue;
		}

		public function render():void
		{
			if (_isRendering)
			{
				enterFrameRender();
			}
		}
		
		public function get renderType():int
		{
			return RenderType.CPU
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
			_intervalTime = 1000 / val;
		}
		
		public function get loopEndCallBack():FunHandler 
		{
			return _loopEndCallBack;
		}
		
		public function set loopEndCallBack(value:FunHandler):void 
		{
			_loopEndCallBack = value;
		}
		
		public function addFrameCallBack(frame:uint, fun:FunHandler):void
		{
			_frameCallBackTable.insert(frame, fun);
		}
		
		public function delFrameCallBack(frame:uint):void
		{
			_frameCallBackTable.del(frame);
		}
	}
}
