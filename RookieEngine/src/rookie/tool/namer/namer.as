package rookie.tool.namer 
{
	/**
	 * 命名工具函数(根据上下层级关系由大到小)
	 * @author Warmly
	 */
	public function namer(key1:*, key2:* = null, key3:* = null, ...args):String 
	{
		var name:String = "[" + String(key1) + "]";
		if (key2)
		{
			name += "[" + String(key2) + "]";
		}
		if (key3)
		{
			name += "[" + String(key3) + "]";
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
