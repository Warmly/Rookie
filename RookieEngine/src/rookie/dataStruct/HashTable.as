package rookie.dataStruct
{
	import flash.utils.getQualifiedClassName;
	import rookie.tool.log.warning;
	import rookie.tool.namer.NameBase;

	import flash.utils.Dictionary;

	/**
	 * Hash Table
	 * 1.Unique key
	 * 2.Perform well in searching
	 * @author Warmly
	 */
	public class HashTable extends NameBase
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
		 * Search
		 */
		public function search(key:*):*
		{
			return _items[key];
		}

		/**
		 * Insert
		 */
		public function insert(key:*, value:*):void
		{
			if (!has(key))
			{
				if (value is _valueType)
				{
					_items[key] = value;
					_length++;
				}
				else
				{
					warning("Try to insert a value of different type '" + getQualifiedClassName(value) + "'into HashTable!");
				}
			}
			else
			{
				warning("Try to insert a key '" + String(key) + "'already exists into HashTable " + _name + "!");
			}
		}

		/**
		 * Delete
		 */
		public function del(key:*):*
		{
			var ret:* = search(key);
			if (ret)
			{
				delete _items[key];
				_length--;
			}
			return ret;
		}
		
		public function clear():void
		{
			if (_length)
			{
				_items = new Dictionary();
				_length = 0;
			}
		}

		public function has(key:*):Boolean
		{
			return _items[key] != undefined;
		}
        
		/**
		 * Used in traversing only, do not modify the content!
		 */
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
