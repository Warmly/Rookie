package rookie.core.time
{
	import rookie.tool.functionHandler.FunHandler;
	
	/**
	 * @author Warmly
	 */
	public class TimerVO
	{
		//键名称，用全局函数namer生成，按功能做好区分，方便在计时器管理器的表里查看
		public var name:String;
		public var intervalTime:int;
		public var outTime:int;
		public var curOutTime:int;
		public var intervalFun:FunHandler;
		public var outFun:FunHandler;
	}
}
