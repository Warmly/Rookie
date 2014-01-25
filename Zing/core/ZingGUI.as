package core 
{
	import com.greensock.easing.Bounce;
	import com.greensock.TweenNano;
	import flash.display.Sprite;
	import gui.ZingLifeBoard;
	import gui.ZingOverBoard;
	import gui.ZingScoreBoard;
	import gui.ZingStageBoard;
	import gui.ZingTimeBar;
	import tool.getZingBmd;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingGUI extends Sprite 
	{
		private var _scoreBoard:ZingScoreBoard;
		private var _stageBoard:ZingStageBoard;
		private var _lifeBoard:ZingLifeBoard;
		private var _timeBar:ZingTimeBar;
		private var _overBoard:ZingOverBoard;
		
		public function ZingGUI() 
		{
			_scoreBoard = new ZingScoreBoard();
			addChild(_scoreBoard);
			
			_stageBoard = new ZingStageBoard();
			_stageBoard.x = 300;
			addChild(_stageBoard);
            
			_lifeBoard = new ZingLifeBoard();
			_lifeBoard.x = 500;
			addChild(_lifeBoard);
			
			_timeBar = new ZingTimeBar();
			_timeBar.y = 169;
			addChild(_timeBar);
			
			_overBoard = new ZingOverBoard();
			_overBoard.x = 60;
			_overBoard.y = -600;
			addChild(_overBoard);
		}
		
		public function popOverBoard():void
		{
			_overBoard.syn();
			TweenNano.to(_overBoard, 1, {y:130, ease:Bounce.easeOut});
		}
		
		public function syn():void
		{
			_scoreBoard.syn();
			_stageBoard.syn();
			_lifeBoard.syn();
			_timeBar.syn();
		}
	}
}