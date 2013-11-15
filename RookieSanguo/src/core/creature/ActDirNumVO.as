package core.creature
{
	/**
	 * @author Warmly
	 */
	public class ActDirNumVO
	{
		private var _id:int;
		private var _dirNum:int;
		private var _groupIdArr:Array;

		public function ActDirNumVO(xml:XML)
		{
			_id = xml.@id;
			_dirNum = xml.@dir;
			_groupIdArr = String(xml.@picID).split(";");
		}

		public function get id():int
		{
			return _id;
		}

		public function get dirNum():int
		{
			return _dirNum;
		}

		public function get groupIdArr():Array
		{
			return _groupIdArr;
		}
	}
}
