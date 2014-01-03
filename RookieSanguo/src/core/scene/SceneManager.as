package core.scene
{
	import core.creature.MyselfCpu;
	import flash.events.MouseEvent;
	import global.ModelEntry;

	import global.SanguoEntry;
	import global.ManagerBase;
	import rookie.tool.log.log;

	/**
	 * @author Warmly
	 */
	public class SceneManager extends ManagerBase
	{
		private var _scene:SanguoScene;
		private var _mapModel:MapModel;
		private var _myself:MyselfCpu;

		public function SceneManager()
		{
			_scene = SanguoEntry.scene;
			_mapModel = ModelEntry.mapModel;
			_myself = SanguoEntry.scene.myself;
		}
		
		public function handleMouseDown(event:MouseEvent):void
		{
			//log("======");
			log(event.localX+" "+event.localY);
			log(event.stageX + " " + event.stageY);
			_myself.x = event.localX;
			_myself.y = event.localY;
			
			//var dir:int = 
		}
	}
}
