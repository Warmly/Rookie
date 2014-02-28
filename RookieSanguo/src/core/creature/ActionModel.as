package core.creature
{
	import global.ModelEntry;
	import global.StaticDataModel;
	import global.ModelBase;

	/**
	 * @author Warmly
	 */
	public class ActionModel extends ModelBase
	{
		private var _actDirNumConfig:Vector.<ActDirNumVO> = new Vector.<ActDirNumVO>();

		public function ActionModel()
		{
			super();
		}

		private function get actDirNumConfig():Vector.<ActDirNumVO>
		{
			if (_actDirNumConfig.length == 0)
			{
				var model:StaticDataModel = ModelEntry.staticDataModel;
				var xmlList:XMLList = model.getXmlConfig("action.xml").action;
				for each (var i : XML in xmlList)
				{
					var vo:ActDirNumVO = new ActDirNumVO(i);
					_actDirNumConfig.push(vo);
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
			for each (var temp : ActDirNumVO in actDirNumConfig)
			{
				if (temp.id == actId)
				{
					if (temp.groupIdArr && temp.groupIdArr[0] == 0)
					{
						voNormal = temp;
					}
					else if (temp.groupIdArr.indexOf(String(groupId)) != -1)
					{
						voSingle = temp;
					}
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
