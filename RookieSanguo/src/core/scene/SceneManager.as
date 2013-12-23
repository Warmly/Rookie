package core.scene
{
	import global.ModelEntry;

	import global.SanguoEntry;
	import global.ManagerBase;

	/**
	 * @author Warmly
	 */
	public class SceneManager extends ManagerBase
	{
		private var _scene:SanguoScene;
		private var _mapModel:MapModel;

		public function SceneManager()
		{
			_scene = SanguoEntry.scene;
			_mapModel = ModelEntry.mapModel;
		}
	}
}
