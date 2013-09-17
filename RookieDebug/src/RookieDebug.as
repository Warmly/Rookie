package
{
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
			RookieEntry.timerManager.setInterval(1000, 10000, true, intervalFun);
			testObjPool();
			
			var img:ImgCpu = new ImgCpu(new ResUrl(311, 26, 106), this);
			img.render();
		}

		private function testObjPool() : void
		{
			var obj : TestItem = ObjectPool.getObject(TestItem) as TestItem;
			obj.act();
		}

		private function intervalFun() : void
		{
			trace("!!!!!!");
		}
	}
}
import rookie.tool.objectPool.IObjPoolItem;

class TestItem implements IObjPoolItem
{
	public var id : int;
	public var name : String;

	public function act() : void
	{
		trace("I am " + name + id);
	}

	public function reset() : void
	{
		id = 1;
		name = "Bob";
	}

	public function dispose() : void
	{
	}
}
