package core.scene
{
	/**
	 * @author Warmly
	 */
	public class MapInfoVO
	{
		private var _id:int;
		private var _name:String;
		private var _fileName:String;

		public function MapInfoVO(xml:XML)
		{
			_id = xml.@mapID;
			_name = xml.@name;
			_fileName = xml.@file;
		}

		public function get id():int
		{
			return _id;
		}

		public function get name():String
		{
			return _name;
		}

		public function get fileName():String
		{
			return _fileName;
		}
	}
}
