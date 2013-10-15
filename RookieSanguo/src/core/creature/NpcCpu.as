package core.creature
{
	import rookie.core.render.AnimCpu;
	import rookie.core.resource.ResUrl;
	import global.ModelEntry;

	import core.creature.CreatureCpu;

	/**
	 * @author Warmly
	 */
	public class NpcCpu extends CreatureCpu
	{
		private var _detailedVO:DetailedNpcVO;

		public function NpcCpu()
		{
			super();
		}

		public function init(staticId:int):void
		{
			_detailedVO = ModelEntry.staticDataModel.detailedNpcDic[staticId];
			if (_body)
			{
				_body.deleteParent();
			}
			var resUrl:ResUrl = new ResUrl(316, staticId);
			_body = new CreaturePartAnimCpu(resUrl);
			_body.parent = this;
		}

		override public function reset():void
		{
			super.reset();
		}

		public function get detailedVO():DetailedNpcVO
		{
			return _detailedVO;
		}

		public function set detailedVO(detailedVO:DetailedNpcVO):void
		{
			_detailedVO = detailedVO;
		}
	}
}
