package rookie.core.frame 
{
	import rookie.tool.functionHandler.FunHandler;
	/**
	 * ...
	 * @author Warmly
	 */
	public class FrameVO 
	{
		//键名称，用全局函数namer生成，按功能做好区分，方便在帧管理器的表里查看
		public var name:String;
		//从创建后经历了多少帧
		public var passedFrame:int;
		public var intervalFrame:int;
		public var outFrame:int;
		public var curOutFrame:int;
		public var intervalFun:FunHandler;
		public var outFun:FunHandler;
	}
}