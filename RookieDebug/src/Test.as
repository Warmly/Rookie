package  
{
	/**
	 * ...
	 * @author Warmly
	 */
	public class Test 
	{
		public function Test() 
		{
			var son:Son = new Son();
			son.B();
			
			var aa:uint = 3 - 6;
			trace(aa);
		}
	}
}

class Father 
{
	public function A():void
	{
		trace("父类调用A");
	}
	
	public function B():void
	{
		trace("父类调用B");
		A();
	}
}

class Son extends Father 
{
	override public function A():void
	{
		trace("子类调用A");
		super.A();
	}
	
	override public function B():void
	{
		trace("子类调用B");
		super.B();
	}
}