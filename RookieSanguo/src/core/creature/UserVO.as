package core.creature
{
	import core.creature.CreatureVO;

	/**
	 * @author Warmly
	 */
	public class UserVO extends CreatureVO
	{
		public var body:uint;
		public var weapon:uint;
		public var horse:uint;
		public var sex:uint;

		public function UserVO()
		{
		}
		
		public function parse():void
		{
			if (this.horse && this.body < 10000)
			{
				this.body += 10000;
			}
			if (this.horse && this.weapon < 10000)
			{
				this.weapon += 10000;
			}
		}
	}
}
