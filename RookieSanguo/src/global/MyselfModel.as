package global
{
	import definition.SanguoDefine;
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
		public var costPerCell:Number = SanguoDefine.MOVE_ONE_CELL_COST;
		
		public function MyselfModel()
		{
			super();
		}
	}
}
