package define 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingEleEnum 
	{
		public static const EMPTY:int = 0;
		public static const TARGET:int = 1;
		public static const OBSTACLE:int = 2;
		public static const BOMB:int = 3;
		public static const BONUS:int = 4;
		public static const CLOCK:int = 5;
		private static var _bmdNameDic:Dictionary = new Dictionary();
		_bmdNameDic[TARGET] = "target";
		_bmdNameDic[OBSTACLE] = "obstacle";
		_bmdNameDic[BOMB] = "bomb";
		_bmdNameDic[BONUS] = "bonus";
		_bmdNameDic[CLOCK] = "clock";
		public static function getBmdName(type:int):String
		{
			return _bmdNameDic[type];
		}
	}
}