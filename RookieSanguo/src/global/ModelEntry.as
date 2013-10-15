package global
{
	import core.creature.ActionModel;

	import global.StaticDataModel;

	/**
	 * @author Warmly
	 */
	public class ModelEntry
	{
		private static var _staticDataModel:StaticDataModel;
		private static var _actionModel:ActionModel;

		public static function get staticDataModel():StaticDataModel
		{
			if (!_staticDataModel)
			{
				_staticDataModel = new StaticDataModel();
			}
			return _staticDataModel;
		}

		public static function get actionModel():ActionModel
		{
			if (!_actionModel)
			{
				_actionModel = new ActionModel();
			}
			return _actionModel;
		}
	}
}
