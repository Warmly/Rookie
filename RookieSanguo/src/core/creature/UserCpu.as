package core.creature
{
	import definition.ActionEnum;
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
			vo.parse();
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
		
		override public function synAction(action:int, direction:int = -1):void
		{
			if (userVO.horse)
			{
				if (action == ActionEnum.STAND)
				{
					action = ActionEnum.STAND_ON_HORSE;
				}
				else if (action == ActionEnum.RUN)
				{
					action = ActionEnum.RUN_ON_HORSE;
				}
			}
			super.synAction(action, direction);
		}
		
		public function get userVO():UserVO
		{
			return _creatureVO as UserVO;
		}
	}
}
