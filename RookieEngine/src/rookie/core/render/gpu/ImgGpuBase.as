package rookie.core.render.gpu 
{
	import rookie.tool.functionHandler.FH
	import rookie.core.render.gpu.base.RookieIndexBuffer;
	import rookie.core.render.gpu.base.RookieShader;
	import rookie.core.render.gpu.base.RookieTexture;
	import rookie.core.render.gpu.base.RookieVertexBuffer;
	import rookie.core.render.IRenderItem;
	import rookie.core.resource.ResUrl;
	import rookie.core.vo.ImgConfigVO;
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.global.RookieEntry;
	import rookie.tool.log.error;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ImgGpuBase implements IRenderItem
	{	
		protected var _imgConfigVO:ImgConfigVO;
		protected var _resUrl:ResUrl;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		
		protected var _vertexBuffer:RookieVertexBuffer;
		protected var _indexBuffer:RookieIndexBuffer;
		protected var _shader:RookieShader;
		protected var _texture:RookieTexture;
		
		public function ImgGpuBase(resUrl:ResUrl = null, loadImmediately:Boolean = true, loadPriority:int = 0) 
		{
			_resUrl = resUrl;
			if (loadImmediately)
			{
				_imgConfigVO = RookieEntry.resManager.getImgConfigVO(_resUrl);
				_width = _imgConfigVO.imgWidth;
				_height = _imgConfigVO.imgHeight;
				RookieEntry.loadManager.load(_resUrl, loadPriority, FH(onImgDataLoaded));
			}
		}
		
		protected function onImgDataLoaded():void 
		{
			if (!_imgConfigVO)
			{
				error("没有" + _resUrl.url + "的配置！");
				return;
			}
			var frameLength:uint = _imgConfigVO.frameLength;
			for (var i:int = 0; i < frameLength; i++) 
			{
				var frame:ImgFrameConfigVO = _imgConfigVO.getFrames(i);
				frame.onImgFrameDataLoaded();
			}
		}
		
		public function manualLoad(resUrl:ResUrl, loadPriority:int = 0):void
		{
			_resUrl = resUrl;
			_imgConfigVO = RookieEntry.resManager.getImgConfigVO(resUrl);
			_width = _imgConfigVO.imgWidth;
			_height = _imgConfigVO.imgHeight;
			RookieEntry.loadManager.load(resUrl, loadPriority, FH(onImgDataLoaded));
		}
		
		public function render():void
		{
		}
		
		public function get key():String
		{
			return _resUrl.url + "[" + "111" + "]";
		}
		
		public function dispose():void
		{
			RookieEntry.renderManager.removeFromQueue(this);
		}
		
		public function get width():Number 
		{
			return _width;
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