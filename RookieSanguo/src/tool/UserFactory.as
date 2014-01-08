package tool
{
	import core.creature.MyselfCpu;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import rookie.tool.objectPool.ObjectPool;
	import core.creature.UserCpu;
	import core.creature.UserVO;
	/**
	 * @author Warmly
	 */
	public class UserFactory
	{
		public static function getTestUserVO():UserVO
		{
			var vo:UserVO = new UserVO();
			vo.body = 201;
			vo.weapon = 117;
			vo.horse = 3216;
			return vo;
		}
		
		public static function getTestUserCpu():UserCpu
		{
			var userCpu:UserCpu = ObjectPool.getObject(UserCpu) as UserCpu;
			userCpu.init(getTestUserVO());
			return userCpu;
		}
		
		public static function getMyselfCpu():MyselfCpu
		{
			var myselfCpu:MyselfCpu = new MyselfCpu();
			myselfCpu.init(getTestUserVO());
			myselfCpu.synAction(ActionEnum.STAND, DirectionEnum.RIGHT_DOWN);
			return myselfCpu;
		}
	}
}
