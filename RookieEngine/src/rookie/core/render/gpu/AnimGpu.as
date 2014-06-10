package rookie.core.render.gpu 
{
	import definition.SanguoDefine;
	import flash.utils.getTimer;
	import rookie.core.render.gpu.base.RookieTexture;
	import rookie.core.render.gpu.factory.RookieTextureFactory;
	import rookie.core.render.RenderManager;
	import rookie.core.resource.ResUrl;
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.dataStruct.HashTable;
	import rookie.global.RookieEntry;
	import rookie.tool.functionHandler.FunHandler;
	import rookie.tool.namer.namer;
	/**
	 * ...
	 * @author Warmly
	 */
	public class AnimGpu extends ImgGpuBase 
	{
		protected var _totalFrame:uint;
		protected var _curFrame:uint = 1;
		// 频率：帧/秒
		protected var _frequency:Number;
		// 当前帧时间
		protected var _curTime:Number;
		// 上一帧时间
		protected var _lastTime:Number = 0;
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
		protected var _frameCallBackTable:HashTable = new HashTable(uint, FunHandler);
		
		public function AnimGpu(resUrl:ResUrl, isAutoPlay:Boolean = true) 
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
		
		override public function render():void
		{
			if (_isRendering)
			{
				renderCurFrame();
				if (_frameCallBackTable.has(_curFrame))
				{
					var fun:FunHandler = _frameCallBackTable.search(_curFrame) as FunHandler;
					fun.execute();
				}
				_curTime = getTimer();
				if (_curTime - _lastTime >= _intervalTime)
				{
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
		}
		
		protected function renderCurFrame():void
		{
			_curFrameVO = _imgConfigVO.getFrame(_curFrame - 1);
			_texture = getCurFrameTexture();
			if (_texture)
			{
				adjustInnerPos();
				var renderManager:RenderManager = RookieEntry.renderManager;
				renderManager.setTextureAt(0, _texture);
				renderManager.setRenderPos(_x, _y, _texture.width, _texture.height);
				renderManager.draw();
			}
		}
		
		public function gotoAndPlay(frame:int):void
		{
			_curFrame = frame;
			startPlay();
		}
		
		public function startPlay():void
		{
			if (!_isRendering)
			{
				_lastTime = getTimer();
				_isRendering = true;
			}
		}
		
		public function stopPlay():void
		{
			_isRendering = false;
		}
		
		protected function getCurFrameTexture():RookieTexture
		{
			_texture = RookieEntry.textureManager.getTexture(namer(_resUrl.url, _curFrame));
			if (_texture)
			{
				return _texture;
			}
			else if (_curFrameVO && _curFrameVO.bitmapData)
			{
				_texture = RookieTextureFactory.createBasicTexture(_curFrameVO.bitmapData);
				_texture.name = namer(_resUrl.url, _curFrame);
				RookieEntry.textureManager.addToCache(_texture);
				return _texture;
			}
			return null;
		}
		
		public function setPlayRange(start:uint, end:uint):void
		{
			_startFrame = start;
			_endFrame = end;
		}
		
		protected function adjustInnerPos():void
		{
			super.x = _originX + _curFrameVO.validRectX;
			super.y = _originY + _curFrameVO.validRectY;
		}
		
		override public function set x(value:Number):void
		{
			_originX = value;
		}

		override public function set y(value:Number):void
		{
			_originY = value;
		}
		
		public function set frequency(value:Number):void 
		{
			_frequency = value;
			_intervalTime = 1000 / value;
		}
		
		public function get loop():uint 
		{
			return _loop;
		}
		
		public function set loop(value:uint):void 
		{
			_loop = value;
		}
		
		public function addFrameCallBack(frame:uint, fun:FunHandler):void
		{
			_frameCallBackTable.insert(frame, fun);
		}
		
		public function delFrameCallBack(frame:uint):void
		{
			_frameCallBackTable.del(frame);
		}
		
	    /**
		 * 仅用于调试，慎用！
		 */
		public function selfStartRender():void
		{
			RookieEntry.renderManager.addToGpuRenderQueue(this);
			startPlay();
		}
	}
}