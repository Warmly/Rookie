package rookie.dataStruct 
{
	import flash.utils.getQualifiedClassName;
	import rookie.tool.log.error;
	/**
	 * 队列，先进先出(FIFO)
	 * @author Warmly
	 */
	public class Queue 
	{
		private var _type:Class;
		private var _items:Vector.<*> = new Vector.<*>();
		
		public function Queue(type:Class) 
		{
			_type = type;
		}
		
		public function push(item:*):void
		{
			if (item is _type)
			{
				_items.push(item);
			}
			else
			{
				error("Try to push a value of different type'" + getQualifiedClassName(item) + "'into Queue!");
			}
		}
		
		public function pop():*
		{
			var item:* = _items.shift();
			return item;
		}
		
		/**
		 * 仅用于遍历，不要修改内容！
		 */
		public function get content():Vector.<*>
		{
			return _items;
		}
		
		public function get length():int
		{
			return _items.length;
		}
	}
}