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
				for each (var i : XML in model.Action.action)
				{
					var vo:ActDirNumVO = new ActDirNumVO();
					vo.id = i.@id;
					vo.dirNum = i.@dir;
					vo.groupIdArr = String(i.@picID).split(";");
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
			for each (var i : ActDirNumVO in actDirNumConfig)
			{
				if (i.id == actId)
				{
					if (i.groupIdArr && i.groupIdArr[0] == 0)
					{
						voNormal = i;
					}
					else
					{
						for each (var ii : int in i.groupIdArr)
						{
							if (ii == groupId)
							{
								voSingle = i;
							}
						}
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
