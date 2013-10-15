package global
{
	import flash.utils.ByteArray;

	/**
	 * @author Warmly
	 */
	public class ParseableVO
	{
		protected var _id:uint;

		public function ParseableVO(byteArr:ByteArray)
		{
			_id = byteArr.readUnsignedInt();
		}

		public function get id():int
		{
			return _id;
		}
	}
}
