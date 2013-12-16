package rookie.dataStruct
{
	import rookie.tool.log.warning;

	import flash.utils.Dictionary;

	/**
	 * 哈希表
	 * 1.键唯一
	 * 2.适用于查找
	 * @author Warmly
	 */
	public class HashTable
	{
		private var _keyType:Class;
		private var _valueType:Class;
		private var _items:Dictionary = new Dictionary();
		private var _length:int;

		public function HashTable(keyType:Class, valueType:Class)
		{
			_keyType = keyType;
			_valueType = valueType;
		}

		/**
		 * 查找
		 */
		public function find(key:*):*
		{
			return _items[key];
		}

		/**
		 * 插入
		 */
		public function insert(key:*, value:*):void
		{
			if (!has(key))
			{
				_items[key] = value;
				_length++;
			}
			else
			{
				warning("Try to insert a key '" + String(key) + "'already exists into HashTable!");
			}
		}

		/**
		 * 删除
		 */
		public function del(key:*):*
		{
			var ret:* = find(key);
			if (ret)
			{
				delete _items[key];
				_length--;
			}
			return ret;
		}

		public function has(key:*):Boolean
		{
			return _items[key] != undefined;
		}

		public function get content():Dictionary
		{
			return _items;
		}

		public function get length():int
		{
			return _length;
		}
	}
}
