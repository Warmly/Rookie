package global
{
	import core.scene.KeyboardHandler;
	import core.scene.SanguoScene;
	import core.scene.SanguoCamera;

	import rookie.global.RookieEntry;

	/**
	 * @author Warmly
	 */
	public class SanguoEntry
	{
		private static var _camera:SanguoCamera;
		private static var _scene:SanguoScene;
		private static var _keyboardHandler:KeyboardHandler;
		private static var _myselfVO:MyselfVO;

		public static function get camera():SanguoCamera
		{
			if (!_camera)
			{
				_camera = new SanguoCamera();
			}
			return _camera;
		}

		public static function get scene():SanguoScene
		{
			if(!_scene)
			{
				_scene = new SanguoScene();
			}
			return _scene;
		}
		
	    public static function get keyboardHandler():KeyboardHandler 
		{
			if (!_keyboardHandler)
			{
				_keyboardHandler = new KeyboardHandler();
			}
			return _keyboardHandler;
		}
		
		public static function get myselfVO():MyselfVO 
		{
			if (!_myselfVO)
			{
				_myselfVO = new MyselfVO();
			}
			return _myselfVO;
		}
	}
}
