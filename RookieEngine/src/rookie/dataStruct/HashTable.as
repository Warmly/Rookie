package rookie.dataStruct
{
	import flash.utils.getQualifiedClassName;
	import rookie.tool.log.warning;
	import rookie.tool.namer.IName;

	import flash.utils.Dictionary;

	/**
	 * 哈希表
	 * 1.键唯一
	 * 2.适用于查找
	 * @author Warmly
	 */
	public class HashTable implements IName
	{
		private var _keyType:Class;
		private var _valueType:Class;
		private var _items:Dictionary = new Dictionary();
		private var _length:int;
		private var _name:String;

		public function HashTable(keyType:Class, valueType:Class)
		{
			_keyType = keyType;
			_valueType = valueType;
		}

		/**
		 * 查找
		 */
		public function search(key:*):*
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
				warning("Try to insert a key '" + String(key) + "'already exists into HashTable" + _name + "!");
			}
		}

		/**
		 * 删除
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
		 * 仅用于遍历，不要修改内容！
		 */
		public function get content():Dictionary
		{
			return _items;
		}

		public function get length():int
		{
			return _length;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
	}
}
