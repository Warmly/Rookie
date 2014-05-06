package core.scene.gpu 
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import global.ModelEntry;
	import rookie.core.render.gpu.base.RookieVertexBuffer;
	import rookie.core.render.gpu.factory.RookieBufferFactory;
	import rookie.core.render.gpu.factory.RookieShaderFactory;
	import rookie.core.render.gpu.factory.RookieTextureFactory;
	import rookie.core.render.RenderManager;
	import rookie.core.resource.ResUrl;
	import rookie.global.RookieEntry;
	import rookie.tool.functionHandler.FH;
	import rookie.tool.objectPool.IObjPoolItem;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MapBlockGpu extends SceneObjGpuBase implements IObjPoolItem
	{
		private var _index:int;
		
		public function MapBlockGpu() 
		{
			super(null);
		}
		
		public function set index(value:int):void 
		{
			if (_index != value)
			{
				_index = value;
				_resUrl = ModelEntry.mapModel.getMapImgUrl(value);
				RookieEntry.loadManager.load(_resUrl, 0, FH(onImgDataLoaded));
			}
		}
		
		override protected function onImgDataLoaded():void
		{
			renderConfig();
		}
		
		override protected function renderConfig():void
		{
			var bmd:BitmapData = RookieEntry.resManager.bmdData.search(_resUrl.url);
			//_width = bmd.width;
			//_height = bmd.height;
			//_vertexBuffer = RookieBufferFactory.createBasicVertexBuffer(_width, _height);
			//_indexBuffer = RookieBufferFactory.createBasicIndexBuffer();
			//_shader = RookieShaderFactory.createBasicShader();
			_texture = RookieTextureFactory.createBasicTexture(bmd);
			_renderReady = true;
		}
		
		override public function render():void
		{
			if (_renderReady)
			{
				var renderManager:RenderManager = RookieEntry.renderManager;
				renderManager.setTextureAt(0, _texture);
				renderManager.setRenderPos(_x, _y, _texture.width, _texture.height);
				renderManager.draw();
			}
		}
		
		public function reset():void
		{
		}

		override public function dispose():void
		{
		}
	}
}