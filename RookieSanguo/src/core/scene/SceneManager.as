package core.scene
{
	import global.SanguoEntry;
	import global.ManagerBase;

	/**
	 * @author Warmly
	 */
	public class SceneManager extends ManagerBase
	{
		private var _scene:SanguoScene;
		
		public function SceneManager()
		{
			_scene = SanguoEntry.scene;
		}
	}
}
