package core.creature 
{
	import definition.ActionEnum;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ActProcess 
	{
		private var _startTime:int;
		private var _endTime:int;
		private var _actionType:int;
		
		public function ActProcess(startTime:int, endTime:int, action:int) 
		{
			_startTime = startTime;
			_endTime = endTime;
			_actionType = action;
		}
	}
}