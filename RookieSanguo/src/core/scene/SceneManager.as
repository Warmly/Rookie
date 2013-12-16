package core.scene
{
	import global.ModelEntry;
	import rookie.core.IMainLoop;

	import global.SanguoEntry;
	import global.ManagerBase;

	/**
	 * @author Warmly
	 */
	public class SceneManager extends ManagerBase implements IMainLoop
	{
		private var _scene:SanguoScene;
		private var _mapModel:MapModel;

		public function SceneManager()
		{
			_scene = SanguoEntry.scene;
			_mapModel = ModelEntry.mapModel;
		}

		public function onEnterFrame():void
		{
			_scene.mapLayer.render();
		}
	}
}
