package
{
	import tool.UserFactory;
	import core.creature.UserCpu;
	import tool.NpcFactory;

	import flash.utils.Dictionary;

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
			// RookieEntry.timerManager.setInterval(1000, 10000, true, intervalFun);
			testObjPool();

			var mainResUrl:ResUrl = new ResUrl();
			mainResUrl.manualSetUrl("D:/sgtxRes/DZSG/resource_debug.swf");
			RookieEntry.loadManager.load(mainResUrl, ResType.PACK_SWF, 0, FH(onMainResLoaded));
			addChild(new Stats());
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
			
			for (var ii:int = 0 ;ii < 10;ii++)
			{
				var user:UserCpu = UserFactory.getTestUserCpu();
				user.parent = scene;
				user.x = 100 + Math.random() * 600;
				user.y = 100 + Math.random() * 600;
				user.synAction(ActionEnum.RUN);
				user.synDirection(DirectionEnum.RIGHT);
			}

			ModelEntry.mapModel.curMapId = 2001;
			ModelEntry.mapModel.loadMap();

			/*var img:ImgCpu = new ImgCpu(new ResUrl(311, 26, 106));
			img.parent = this;


			var anim1:AnimCpu = new AnimCpu(new ResUrl(310, 1, 648));
			anim1.x = 350;
			anim1.y = 200;
			anim1.loop = 2;*/

			var anim:AnimCpu = new AnimCpu(new ResUrl(311, 26, 139));
			anim.x = 200;
			anim.y = 200;
			anim.parent = this;
			/*anim1.parent = this;

			var testVec:Vector.<TestItem> = new Vector.<TestItem>();
			var a:TestItem = new TestItem();
			a.id = 3;
			testVec.push(a);
			var b:TestItem = new TestItem();
			b.id = 19;
			testVec.push(b);
			var c:TestItem = new TestItem();
			c.id = 8;
			testVec.push(c);
			testVec.sort(aaa);*/
		}

		private function aaa(a:TestItem, b:TestItem):Number
		{
			if (a.id <= b.id)
			{
				return -1;
			}
			else
			{
				return 1;
			}
		}

		private function testObjPool():void
		{
			var obj:TestItem = ObjectPool.getObject(TestItem) as TestItem;
			obj.act();

			var dic:Dictionary = new Dictionary();
			trace(dic["aa"]);
			trace(!dic["aa"]);
		}

		private function intervalFun():void
		{
			trace("!!!!!!");
		}
	}
}
import rookie.tool.objectPool.IObjPoolItem;

class TestItem implements IObjPoolItem
{
	public var id:int;
	public var name:String;

	public function act():void
	{
		trace("I am " + name + id);
	}

	public function reset():void
	{
		id = 1;
		name = "Bob";
	}

	public function dispose():void
	{
	}
}
