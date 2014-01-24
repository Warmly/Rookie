package core 
{
	import com.greensock.easing.Bounce;
	import com.greensock.TweenNano;
	import flash.display.Sprite;
	import gui.ZingLifeBoard;
	import gui.ZingOverBoard;
	import gui.ZingScoreBoard;
	import gui.ZingTimeBar;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingGUI extends Sprite 
	{
		private var _scoreBoard:ZingScoreBoard;
		private var _lifeBoard:ZingLifeBoard;
		private var _timeBar:ZingTimeBar;
		private var _overBoard:ZingOverBoard;
		
		public function ZingGUI() 
		{
			_scoreBoard = new ZingScoreBoard();
			addChild(_scoreBoard);
            
			_lifeBoard = new ZingLifeBoard();
			_lifeBoard.x = 500;
			addChild(_lifeBoard);
			
			_timeBar = new ZingTimeBar();
			_timeBar.y = 90;
			addChild(_timeBar);
			
			_overBoard = new ZingOverBoard();
			_overBoard.x = 60;
			_overBoard.y = -600;
			addChild(_overBoard);
		}
		
		public function popOver():void
		{
			TweenNano.to(_overBoard, 1, {y:130, ease:Bounce.easeOut});
		}
		
		public function syn():void
		{
			_scoreBoard.syn();
			_lifeBoard.syn();
			_timeBar.syn();
		}
	}
}