package
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import rookie.core.resource.LoadPriority;
	import tool.UserFactory;
	import core.creature.UserCpu;
	import tool.NpcFactory;

	import core.scene.SanguoScene;

	import definition.DirectionEnum;
	import definition.ActionEnum;

	import core.creature.NpcCpu;

	import global.ModelEntry;

	import rookie.core.render.AnimCpu;
	import rookie.tool.functionHandler.FH;
	import rookie.core.resource.ResType;
	import rookie.core.resource.ResUrl;
	import rookie.core.render.ImgCpu;
	import rookie.tool.objectPool.ObjectPool;
	import rookie.global.RookieEntry;

	import flash.display.Sprite;

	[SWF(backgroundColor="#ffffff", frameRate="60", width="800", height="600")]
	public class RookieDebug extends Sprite
	{
		public function RookieDebug()
		{
			RookieEntry.mainLoop.init(this.stage);

			var mainResUrl:ResUrl = new ResUrl(-1, -1, "resource_debug", ResType.PACK_SWF, "");
			RookieEntry.loadManager.load(mainResUrl, LoadPriority.HIGH, FH(onMainResLoaded));
			addChild(new Stats());
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
		}

		private function onMainResLoaded():void
		{
			RookieEntry.resManager.init();

			var scene:SanguoScene = new SanguoScene();
			scene.parent = this;

			ModelEntry.staticDataModel;

			/*for (var i:int = 0 ;i < 10;i++)
			{
				var npc:NpcCpu = NpcFactory.getTestNpcCpu();
				npc.parent = scene;
				npc.x = 100 + Math.random() * 600;
				npc.y = 100 + Math.random() * 600;
				npc.synAction(ActionEnum.RUN);
				npc.synDirection(DirectionEnum.LEFT);
			}*/
			
			for (var ii:int = 0 ;ii < 2;ii++)
			{
				var user:UserCpu = UserFactory.getTestUserCpu();
				user.parent = this;
				user.x = 100 + Math.random() * 600;
				user.y = 100 + Math.random() * 600;
				user.synAction(ActionEnum.RUN);
				user.synDirection(DirectionEnum.RIGHT);
			}

			ModelEntry.mapModel.curMapId = 2005;
			ModelEntry.mapModel.loadMap();

			var anim:AnimCpu = new AnimCpu(new ResUrl(311, 26, 139));
			anim.x = 200;
			anim.y = 200;
			anim.parent = this;
			
			new Test();
		}
	}
}
