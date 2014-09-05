package rookie.core.render.gpu 
{
	import rookie.core.resource.LoadPriorityEnum;
	import rookie.tool.functionHandler.fh;
	import rookie.core.render.gpu.base.RookieIndexBuffer;
	import rookie.core.render.gpu.base.RookieShader;
	import rookie.core.render.gpu.base.RookieTexture;
	import rookie.core.render.gpu.base.RookieVertexBuffer;
	import rookie.core.resource.ResUrl;
	import rookie.core.vo.ImgConfigVO;
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.global.RookieEntry;
	import rookie.tool.log.error;
	import rookie.tool.namer.NameBase;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ImgGpuBase extends NameBase
	{	
		protected var _imgConfigVO:ImgConfigVO;
		protected var _resUrl:ResUrl;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		//舞台坐标
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		//当前贴图
		protected var _texture:RookieTexture;
		//资源是否加载完毕
		protected var _resLoaded:Boolean;
		//渲染就绪
		protected var _renderReady:Boolean;
		
		public function ImgGpuBase(resUrl:ResUrl = null, loadImmediately:Boolean = true, loadPriority:int = LoadPriorityEnum.LOW) 
		{
			_resUrl = resUrl;
			if (resUrl && loadImmediately)
			{
				_imgConfigVO = RookieEntry.resManager.getImgConfigVO(_resUrl);
				RookieEntry.loadManager.load(_resUrl, loadPriority, fh(onImgDataLoaded, resUrl));
			}
		}
		
		protected function onImgDataLoaded(resUrl:ResUrl):void 
		{
			if (!_imgConfigVO)
			{
				error("没有" + _resUrl.url + "的配置！");
				return;
			}
			_width = _imgConfigVO.imgWidth;
			_height = _imgConfigVO.imgHeight;
			var frameLength:uint = _imgConfigVO.frameLength;
			for (var i:int = 0; i < frameLength; i++) 
			{
				var frame:ImgFrameConfigVO = _imgConfigVO.getFrame(i);
				frame.onImgFrameDataLoaded();
			}
			_resLoaded = true;
		}
		
		public function manualLoad(resUrl:ResUrl = null, loadPriority:int = LoadPriorityEnum.LOW):void
		{
			if (resUrl)
			{
				_resUrl = resUrl;
			}
			_imgConfigVO = RookieEntry.resManager.getImgConfigVO(resUrl);
			RookieEntry.loadManager.load(resUrl, loadPriority, fh(onImgDataLoaded, resUrl));
		}
		
		/**
		 * to be override
		 */
		protected function renderInit(resUrl:ResUrl):void
		{
		}
		
		/**
		 * to be override
		 */
		public function render():void
		{
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function setPosition(posX:Number, posY:Number):void
		{
			_x = posX;
			_y = posY;
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
	}
}



