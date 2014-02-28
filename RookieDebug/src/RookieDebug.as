package
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	import rookie.algorithm.pathFinding.aStar.AStar;
	import rookie.algorithm.pathFinding.aStar.AStarNode;
	import rookie.core.resource.LoadPriority;
	import tool.TextTool;
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

			ModelEntry.staticDataModel;

			var anim:AnimCpu = new AnimCpu(new ResUrl(311, 26, 139));
			anim.x = 200;
			anim.y = 200;
			anim.parent = this;
			
			new Test();
			
			var aStarTestArr:Array = [
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0
			];
			
			var aStar:AStar = new AStar();
			aStar.parseArrToMap(aStarTestArr, 10, 10);
			aStar.init(0, 0, 3, 5);
			aStar.findPath();
			
			var text:TextField = TextTool.getLightTextField(200, true, 20, true);
			text.htmlText = TextTool.getHtmlText("么么么么么", );
		}
	}
}
