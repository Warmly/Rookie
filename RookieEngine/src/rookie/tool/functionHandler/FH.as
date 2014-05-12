package rookie.tool.functionHandler
{
	/**
	 * @author Warmly
	 */
	public function fh(fun:Function, ...args):FunHandler
	{
		return new FunHandler(fun, args);
	}
}
