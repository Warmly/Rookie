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
		private var _gui:ZingGUI;
		private var _cover:ZingCover;
		
		public function ZingGame() 
		{
			_scene = ZingEntry.zingScene;
			addChild(_scene);
			
			_gui = ZingEntry.zingGUI;
			addChild(_gui);
			
			_cover = ZingEntry.zingCover;
			addChild(_cover);
		}
	}
}