package global
{
	import core.scene.SanguoCamera;

	import rookie.global.RookieEntry;

	/**
	 * @author Warmly
	 */
	public class SanguoEntry
	{
		private static var _rookie:RookieEntry;
		private static var _camera:SanguoCamera;

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
	}
}
