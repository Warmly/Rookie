package core.creature
{
	import definition.SanguoDefine;
	import global.ParseableVO;

	import flash.utils.ByteArray;

	/**
	 * @author Warmly
	 */
	public class NpcConfigVO extends ParseableVO
	{
		private var _name:String;
		private var _type:uint;
		private var _quality:uint;
		private var _level:uint;
		//npc图片
		private var _pic:uint;
		//头像
		private var _face:uint;
		//胸像
		private var _bust:uint;
		private var _atkFlag:uint;
		private var _visitFlag:uint;
		private var _moveRange:uint;
		private var _reward:uint;

		public function NpcConfigVO(byteArr:ByteArray)
		{
			super(byteArr);
			_name = byteArr.readMultiByte(SanguoDefine.MAX_NAME_SIZE + 1, SanguoDefine.CHARSET);
			_type = byteArr.readByte();
			_quality = byteArr.readByte();
			_level = byteArr.readUnsignedShort();
			_pic = byteArr.readUnsignedShort();
			_face = byteArr.readUnsignedShort();
			_bust = byteArr.readUnsignedShort();
			_atkFlag = byteArr.readUnsignedByte();
			_visitFlag = byteArr.readUnsignedByte();
			//_moveRange = byteArr.readByte();
			_reward = byteArr.readUnsignedInt();
		}

		public function get pic():uint
		{
			return _pic;
		}
	}
}
