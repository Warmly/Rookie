package rookie.global
{
	import rookie.core.frame.FrameManager;
	import rookie.core.render.gpu.texture.TextureManager;
	import rookie.core.resource.ResManager;
	import rookie.core.resource.LoadManager;
	import rookie.core.render.RenderManager;
	import rookie.core.time.TimerManager;
	import rookie.core.MainLoop;

	/**
	 * @author Warmly
	 */
	public class RookieEntry
	{
		private static var _mainLoop:MainLoop;
		private static var _resManager:ResManager;
		private static var _timerManager:TimerManager;
		private static var _renderManager:RenderManager;
		private static var _frameManager:FrameManager;
		private static var _loadManager:LoadManager;
		private static var _textureManager:TextureManager;

		public static function get mainLoop():MainLoop
		{
			if (!_mainLoop)
			{
				_mainLoop = new MainLoop();
			}
			return _mainLoop;
		}

		public static function get timerManager():TimerManager
		{
			if (!_timerManager)
			{
				_timerManager = new TimerManager();
			}
			return _timerManager;
		}

		public static function get renderManager():RenderManager
		{
			if (!_renderManager)
			{
				_renderManager = new RenderManager();
			}
			return _renderManager;
		}

		public static function get loadManager():LoadManager
		{
			if (!_loadManager)
			{
				_loadManager = new LoadManager();
			}
			return _loadManager;
		}

		public static function get resManager():ResManager
		{
			if (!_resManager)
			{
				_resManager = new ResManager();
			}
			return _resManager;
		}
		
		public static function get frameManager():FrameManager 
		{
			if (!_frameManager)
			{
				_frameManager = new FrameManager();
			}
			return _frameManager;
		}
		
		public static function get textureManager():TextureManager 
		{
			if (!_textureManager)
			{
				_textureManager = new TextureManager();
			}
			return _textureManager;
		}
	}
}
