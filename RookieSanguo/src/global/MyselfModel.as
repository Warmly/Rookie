package global
{
	import global.ModelBase;

	/**
	 * @author Warmly
	 */
	public class MyselfModel extends ModelBase
	{
		public var cellX:int;
		public var cellY:int;
		/**
	     * 移动一格耗时
	     */
		public var costPerCell:Number = 400;
		
		public function MyselfModel()
		{
			super();
		}
	}
}
