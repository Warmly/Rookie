package core.creature
{
	import rookie.core.resource.ResUrl;

	/**
	 * @author Warmly
	 */
	public class UserCpu extends CreatureCpu
	{
		public function UserCpu()
		{
			super();
		}
		
		public function init(vo:UserVO):void
		{
			_creatureVO = vo;
			_partsContainer.reset();
			
			var bodyUrl:ResUrl = new ResUrl(317, -1, vo.body);
			_partsContainer.initBody(bodyUrl);
			
			var weaponUrl:ResUrl = new ResUrl(307, -1, vo.weapon);
			_partsContainer.initWeapon(weaponUrl);
			
			if (vo.horse)
			{
				var horseUrl:ResUrl = new ResUrl(316, -1, vo.horse);
				_partsContainer.initHorse(horseUrl);
			}
		}
		
		public function get userVO():UserVO
		{
			return _creatureVO as UserVO;
		}
	}
}
