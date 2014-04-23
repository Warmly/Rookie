package rookie.core.render.gpu.2d 
{
	import dzb.base.funHandler.FH;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.textures.Texture;
	import flash.display3D.VertexBuffer3D;
	import rookie.core.resource.ResUrl;
	import rookie.core.vo.ImgConfigVO;
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.global.RookieEntry;
	import rookie.tool.log.error;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ImgGpuBase 
	{
		protected var _imgConfigVO:ImgConfigVO;
		protected var _resUrl:ResUrl;
		protected var _width:Number;
		protected var _height:Number;
		
		protected var _vertexData:Vector.<Number>;
		protected var _indexData:Vector.<Number>;
		protected var _vertexBuffer:VertexBuffer3D;
		protected var _indexBuffer:IndexBuffer3D;
		protected var _shader:Program3D;
		protected var _texture:Texture;
		
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
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function get height():Number 
		{
			return _height;
		}
	}
}