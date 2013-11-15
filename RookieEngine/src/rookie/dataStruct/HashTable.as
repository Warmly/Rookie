package rookie.dataStruct
{
	import flash.utils.Dictionary;

	/**
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

		public function find(key:*):*
		{
			return _items[key];
		}

		public function insert(key:*, value:*):void
		{
			if (!_items[key])
			{
				_items[key] = value;
				_length++;
			}
		}

		public function get length():int
		{
			return _length;
		}
	}
}
