package
{
	import rookie.core.render.AnimCpu;
	import rookie.tool.functionHandler.FH;
	import rookie.core.resource.ResType;
	import rookie.core.resource.ResUrl;
	import rookie.core.render.ImgCpu;
	import rookie.tool.objectPool.ObjectPool;
	import rookie.global.RookieEntry;

	import flash.display.Sprite;

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
		}

		private function onMainResLoaded():void
		{
			RookieEntry.resManager.init();
			var img:ImgCpu = new ImgCpu(new ResUrl(311, 26, 106));
			img.parent = this;

			var anim:AnimCpu = new AnimCpu(new ResUrl(311, 26, 139));
			anim.x = 200;
			anim.y = 200;
			
			var anim1:AnimCpu = new AnimCpu(new ResUrl(311, 26, 139));
			anim1.x = 300;
			anim1.y = 200;
			
			anim.parent = this;
			anim1.parent = this;
		}

		private function testObjPool():void
		{
			var obj:TestItem = ObjectPool.getObject(TestItem) as TestItem;
			obj.act();
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
