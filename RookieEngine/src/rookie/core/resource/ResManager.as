package rookie.core.resource
{
	import rookie.namespace.Rookie;

	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class ResManager
	{
		// 二进制数据的字典
		private var _byteArrDataDic:Dictionary = new Dictionary();
		// 位图数据的字典
		private var _bmdDataDic:Dictionary = new Dictionary();

		public function ResManager()
		{
		}

		Rookie function setByteArrData(url:String, byteArr:ByteArray):void
		{
			_byteArrDataDic[url] = byteArr;
		}

		Rookie function setBmdData(url:String, bmd:BitmapData):void
		{
			_bmdDataDic[url] = bmd;
		}
	}
}
