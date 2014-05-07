package rookie.core.resource
{
	/**
	 * 资源路径
	 * 1.-1表示无该级路径
	 * @author Warmly
	 */
	public class ResUrl
	{
		private static const _ROOT_PATH:String = "E:/SanguoTX/Res/";
		private var _packId:int;
		private var _groupId:int;
		private var _fileName:*;
		private var _url:String;
		private var _resType:int = ResType.SWF;

		public function ResUrl(packId:int = -1, groupId:int = -1, fileName:* = -1, resType:int = 0, subPath:String = "3guores/")
		{
			_packId = packId;
			_groupId = groupId;
			_fileName = fileName;
			_resType = resType;
			
			var packPath:String = packId != -1 ? packId + "/" : "";
			var groupPath:String = groupId != -1 ? groupId + "/" : "";
			var fileNamePath:String = fileName != -1 ? fileName : "";
			
			_url = _ROOT_PATH + subPath + packPath + groupPath + fileNamePath;
		
			_url += ResType.getTailByType(resType);
		}

		public function equal(resUrl:ResUrl):Boolean
		{
			return _packId == resUrl.packId &&
			       _groupId == resUrl.groupId &&
				   _fileName == resUrl.fileName &&
				   _url == resUrl.url;
		}
		
		public function manualSetUrl(url:String, resType:int = 0):void
		{
			_url = _ROOT_PATH + url;
			_resType = resType;
		}

		public function get url():String
		{
			return _url;
		}

		public function get packId():int
		{
			return _packId;
		}

		public function get groupId():int
		{
			return _groupId;
		}

		public function get fileName():*
		{
			return _fileName;
		}
		
		public function get resType():int
		{
			return _resType;
		}
	}
}
