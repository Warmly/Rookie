package rookie.core.resource
{
	/**
	 * @author Warmly
	 */
	public class ResUrl
	{
		private static const _ROOT_PATH:String = "";
		private var _packId:int;
		private var _groupId:int;
		private var _imageId:int;
		private var _url:String;

		public function ResUrl(packId:int = -1, groupId:int = -1, imageId:int = -1)
		{
			_packId = packId;
			_groupId = groupId;
			_imageId = imageId;
			_url = _ROOT_PATH + _packId + "/" + _groupId + "/" + _imageId + ".swf";
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

		public function get imageId():int
		{
			return _imageId;
		}
	}
}
