package rookie.tool.log
{
	import rookie.tool.namer.namer;
	/**
	 * @author Warmly
	 */
	public function log(content:String):void
	{
		trace(namer("log", content));
	}
}
