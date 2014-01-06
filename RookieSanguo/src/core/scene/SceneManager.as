package core.scene
{
	import core.creature.MyselfCpu;
	import definition.DirectionEnum;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import global.ModelEntry;
	import tool.SanguoCoorTool;

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
			var sceneCoor:Point = SanguoCoorTool.cameraToScene(event.stageX, event.stageY);
			var dir:int = DirectionEnum.getDirection(_myself.x, _myself.y, sceneCoor.x, sceneCoor.y);
			_myself.synDirection(dir);
		}
		
		public function handleMyselfMove():void
		{
		}
	}
}
