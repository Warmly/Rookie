package rookie.tool.namer 
{
	/**
	 * ...
	 * @author Warmly
	 */
	public class NameBase 
	{
		protected var _name:String;
		
		public function NameBase() 
		{
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
	}
}