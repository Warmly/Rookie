package core.creature
{
	import rookie.dataStruct.HashTable;

	import global.ModelEntry;
	import global.StaticDataModel;
	import global.ModelBase;

	/**
	 * @author Warmly
	 */
	public class ActionModel extends ModelBase
	{
		private var _actDirNumConfig:HashTable = new HashTable(int, ActDirNumVO);

		public function ActionModel()
		{
			super();
		}

		private function get actDirNumConfig():HashTable
		{
			if (_actDirNumConfig.length == 0)
			{
				var model:StaticDataModel = ModelEntry.staticDataModel;
				var xmlList:XMLList = model.Action.action;
				for each (var i : XML in xmlList)
				{
					var vo:ActDirNumVO = new ActDirNumVO(i);
					_actDirNumConfig.insert(vo.id, vo);
				}
			}
			return _actDirNumConfig;
		}

		public function getActDirNum(actId:uint, groupId:uint):int
		{
			// 通用，未配picID的
			var voNormal:ActDirNumVO;
			// 单独配picID了的
			var voSingle:ActDirNumVO;
			var temp:ActDirNumVO = actDirNumConfig.find(actId);
			if (temp)
			{
				if (temp.groupIdArr && temp.groupIdArr[0] == 0)
				{
					voNormal = temp;
				}
				else if (temp.groupIdArr.indexOf(groupId) != -1)
				{
					voSingle = temp;
				}
			}
			if (voSingle)
			{
				return voSingle.dirNum;
			}
			if (voNormal)
			{
				return voNormal.dirNum;
			}
			return 0;
		}
	}
}
