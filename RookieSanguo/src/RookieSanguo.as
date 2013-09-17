package
{
	import rookie.global.RookieEntry;

	import flash.display.Sprite;

	[SWF(backgroundColor="#ffffff", frameRate="60", width="800", height="600")]
	public class RookieSanguo extends Sprite
	{
		public function RookieSanguo()
		{
			RookieEntry.mainLoop.init(this.stage);
			addChild(new Stats());
		}
	}
}
