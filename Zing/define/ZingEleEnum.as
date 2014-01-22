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
		private static var _bmdNameDic:Dictionary = new Dictionary();
		_bmdNameDic[TARGET] = "target";
		_bmdNameDic[OBSTACLE] = "obstacle";
		public static function getBmdName(type:int):String
		{
			return _bmdNameDic[type];
		}
	}
}