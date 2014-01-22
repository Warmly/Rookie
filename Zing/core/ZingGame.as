package core 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingGame extends Sprite 
	{
		private var _scene:ZingScene;
		
		public function ZingGame() 
		{
			_scene = ZingEntry.zingScene;
			addChild(_scene);
			
			_scene.init();
		}
	}
}