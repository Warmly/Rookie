package core.creature
{
	import rookie.core.resource.ResUrl;

	import core.creature.CreatureCpu;

	/**
	 * @author Warmly
	 */
	public class NpcCpu extends CreatureCpu
	{
		public function NpcCpu()
		{
			super();
		}

		public function init(vo:NpcVO):void
		{
			_creatureVO = vo;
			_partsContainer.reset();
			var resUrl:ResUrl = new ResUrl(316, vo.detail.pic);
			_partsContainer.initBody(resUrl);
		}

		public function get npcVO():NpcVO
		{
			return _creatureVO as NpcVO;
		}
	}
}
