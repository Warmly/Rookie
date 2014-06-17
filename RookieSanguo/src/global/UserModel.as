package global 
{
	import core.creature.UserVO;
	import rookie.dataStruct.HashTable;
	/**
	 * ...
	 * @author Warmly
	 */
	public class UserModel extends ModelBase 
	{
		private var _ref:HashTable = new HashTable(Number, UserVO);
		
		public function UserModel() 
		{
		}
		
		public function addUser(vo:UserVO):void
		{
			_ref.insert(vo.id, vo);
		}
		
		public function hasUser(id:Number):Boolean
		{
			return _ref.has(id);
		}
	}
}