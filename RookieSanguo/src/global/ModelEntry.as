package global
{
	/**
	 * @author Warmly
	 */
	public class ModelEntry
	{
		private static var _imgDataModel:ImgDataModel;

		public static function get imgDataModel():ImgDataModel
		{
			if (_imgDataModel == null)
			{
				_imgDataModel = new ImgDataModel();
			}
			return _imgDataModel;
		}
	}
}
