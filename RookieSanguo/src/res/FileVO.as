package res 
{
	import definition.SanguoDefine;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Warmly
	 */
	public class FileVO 
	{
		private var _offset:uint;
		private var _lengthBeforeCompress:uint;
		private var _lengthAfterCompress:uint;
		private var _nameLength:uint;
		private var _name:String;
		
		public function FileVO(byteArr:ByteArray) 
		{
			_offset = byteArr.readUnsignedInt();
			_lengthBeforeCompress = byteArr.readUnsignedInt();
			_lengthAfterCompress = byteArr.readUnsignedInt();
			_nameLength = byteArr.readUnsignedByte();
			_name = byteArr.readMultiByte(_nameLength, SanguoDefine.CHARSET);
			_name = _name.toLowerCase();
		}
		
		public function get offset():uint
		{
			return _offset;
		}
		
		public function get lengthAfterCompress():uint
		{
			return _lengthAfterCompress;
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}