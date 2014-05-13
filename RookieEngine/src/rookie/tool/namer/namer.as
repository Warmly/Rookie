package rookie.tool.namer 
{
	/**
	 * 命名工具函数(根据上下层级关系由大到小)
	 * @author Warmly
	 */
	public function namer(key1:String, key2:String = "", key3:String = "", ...args):String 
	{
		var name:String = "[" + key1 + "]";
		if (key2)
		{
			name += "[" + key2 + "]";
		}
		if (key3)
		{
			name += "[" + key3 + "]";
		}
		var extra:Array = args;
		var num:int = extra.length;
		for (var i:int = 0; i < num; i++) 
		{
			var extraKey:String = extra[i];
			if (extraKey)
			{
				name += "[" + extraKey + "]";
			}
		}
		return name;
	}
}
