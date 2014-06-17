package global
{
	import core.scene.MapModel;
	import core.creature.ActionModel;

	import global.StaticDataModel;

	/**
	 * @author Warmly
	 */
	public class ModelEntry
	{
		private static var _staticDataModel:StaticDataModel;
		private static var _mapModel:MapModel;
		private static var _actionModel:ActionModel;
		private static var _userModel:UserModel;

		public static function get staticDataModel():StaticDataModel
		{
			if (!_staticDataModel)
			{
				_staticDataModel = new StaticDataModel();
			}
			return _staticDataModel;
		}

		public static function get mapModel():MapModel
		{
			if(!_mapModel)
			{
				_mapModel = new MapModel();
			}
			return _mapModel;
		}

		public static function get actionModel():ActionModel
		{
			if (!_actionModel)
			{
				_actionModel = new ActionModel();
			}
			return _actionModel;
		}
		
		public static function get userModel():UserModel
		{
			if (!_userModel)
			{
				_userModel = new UserModel();
			}
			return _userModel;
		}
	}
}
