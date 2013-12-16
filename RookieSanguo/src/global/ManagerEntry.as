package global
{
	import core.scene.SceneManager;

	/**
	 * @author Warmly
	 */
	public class ManagerEntry
	{
		private static var _sceneManager:SceneManager;

		public static function get sceneManager():SceneManager
		{
			if(!_sceneManager)
			{
				_sceneManager = new SceneManager();
			}
			return _sceneManager;
		}
	}
}
