package rookie.tool.functionHandler
{
	/**
	 * @author Warmly
	 */
	public class FunHandler
	{
		private var _fun:Function;
		private var _args:Array;

		public function FunHandler(fun:Function, args:Array):void
		{
			_fun = fun;
			_args = args;
		}

		public function execute():void
		{
			if (_fun != null)
			{
				_fun.apply(_fun, _args);
			}
		}
	}
}
