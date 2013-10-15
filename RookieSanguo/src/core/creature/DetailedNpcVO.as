package core.creature
{
	import definition.Define;

	import global.ParseableVO;

	import flash.utils.ByteArray;

	/**
	 * @author Warmly
	 */
	public class DetailedNpcVO extends ParseableVO
	{
		private var _name:String;
		private var _type:uint;
		private var _quality:uint;
		private var _level:uint;
		private var _pic:uint;
		private var _face:uint;
		private var _atkFlag:uint;
		private var _visitFlag:uint;
		private var _moveRange:uint;

		public function DetailedNpcVO(byteArr:ByteArray)
		{
			super(byteArr);
			_name = byteArr.readMultiByte(Define.MAX_NAME_SIZE + 1, Define.CHARSET);
			_type = byteArr.readByte();
			_quality = byteArr.readByte();
			_level = byteArr.readUnsignedShort();
			_pic = byteArr.readUnsignedShort();
			_face = byteArr.readUnsignedShort();
			_atkFlag = byteArr.readUnsignedByte();
			_visitFlag = byteArr.readUnsignedByte();
			_moveRange = byteArr.readByte();
		}
	}
}
