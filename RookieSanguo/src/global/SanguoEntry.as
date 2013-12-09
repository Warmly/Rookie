package global
{
	import core.scene.SanguoScene;
	import core.scene.SanguoCamera;

	import rookie.global.RookieEntry;

	/**
	 * @author Warmly
	 */
	public class SanguoEntry
	{
		private static var _rookie:RookieEntry;
		private static var _camera:SanguoCamera;
		private static var _scene:SanguoScene;

		public static function get rookie():RookieEntry
		{
			if (!_rookie)
			{
				_rookie = new RookieEntry();
			}
			return _rookie;
		}

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
	}
}
