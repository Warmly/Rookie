package core 
{
	import config.ZingConfig;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingEntry 
	{
		private static var _root:ZingGame;
		private static var _zingCover:ZingCover;
		private static var _zingRes:ZingRes;
		private static var _zingScene:ZingScene;
		private static var _zingConfig:ZingConfig;
		private static var _zingModel:ZingModel;
		private static var _zingLogic:ZingLogic;
		private static var _zingGUI:ZingGUI;
		
		public function ZingEntry() 
		{
		}
		
		public static function get root():ZingGame
		{
			if (!_root)
			{
				_root = new ZingGame();
			}
			return _root;
		}
		
		public static function get zingRes():ZingRes
		{
			if (!_zingRes)
			{
				_zingRes = new ZingRes();
			}
			return _zingRes;
		}
		
		public static function get zingScene():ZingScene
		{
			if (!_zingScene)
			{
				_zingScene = new ZingScene();
			}
			return _zingScene;
		}
		
		public static function get zingConfig():ZingConfig
		{
			if (!_zingConfig)
			{
				_zingConfig = new ZingConfig();
			}
			return _zingConfig;
		}
		
		public static function get zingModel():ZingModel
		{
			if (!_zingModel)
			{
				_zingModel = new ZingModel();
			}
			return _zingModel;
		}
		
		public static function get zingLogic():ZingLogic
		{
			if (!_zingLogic)
			{
				_zingLogic = new ZingLogic();
			}
			return _zingLogic;
		}
		
		public static function get zingGUI():ZingGUI
		{
			if (!_zingGUI)
			{
				_zingGUI = new ZingGUI();
			}
			return _zingGUI;
		}
		
		public static function get zingCover():ZingCover
		{
			if (!_zingCover)
			{
				_zingCover = new ZingCover();
			}
			return _zingCover;
		}
	}
}