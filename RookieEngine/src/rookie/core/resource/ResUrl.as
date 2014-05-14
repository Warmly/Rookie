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
		//private static const _ROOT_PATH:String = "";
		private var _subPath:String;
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
			_subPath = subPath;
		}

		public function equal(resUrl:ResUrl):Boolean
		{
			return _packId == resUrl.packId &&
			       _groupId == resUrl.groupId &&
				   _fileName == resUrl.fileName &&
				   _resType == resUrl.resType;
		}
		
		public function manualSetUrl(url:String, resType:int = 0):void
		{
			_url = _ROOT_PATH + url;
			_resType = resType;
		}

		public function get url():String
		{
			if (!_url)
			{
				var packPath:String = _packId != -1 ? _packId + "/" : "";
				var groupPath:String = _groupId != -1 ? _groupId + "/" : "";
				var fileNamePath:String = _fileName != -1 ? _fileName : "";
				_url = _ROOT_PATH + _subPath + packPath + groupPath + fileNamePath;
				_url += ResType.getTailByType(_resType);
			}
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
