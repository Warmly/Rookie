package rookie.tool.functionHandler
{
	/**
	 * @author Warmly
	 */
	public function FH(fun:Function, ...args):FunHandler
	{
		return new FunHandler(fun, args);
	}
}
