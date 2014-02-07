package gui 
{
	import com.greensock.TweenNano;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import rookie.tool.math.RookieMath;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingNumber extends Sprite 
	{
		private var _number:Number;
		private var _ref:Vector.<ZingDigit> = new Vector.<ZingDigit>();
			
		public function ZingNumber() 
		{
		}
		
		public function set number(val:Number):void
		{
			var arr:Array = String(val).match(/\d/igx);
			var length:int = arr.length;
			resize(length);
			for (var i:int = 0; i < length; i++)
			{
				var tmp:ZingDigit = _ref[i];
				var oldVal:int = tmp.val;
				var newVal:int = arr[i];
				var isNewValBigger:Boolean = newVal >= oldVal;
				var time:Number = (isNewValBigger ? newVal - oldVal : newVal) * 0.1;
				if (isNewValBigger)
				{
					TweenNano.to(tmp, time, { val:newVal });
				}
				else
				{
					tmp.val = newVal;
				}
			}
		}
		
		private function resize(newLength:int):void
		{
			var oldLength:int = _ref.length;
			var diff:int = newLength - oldLength;
			var tmp:ZingDigit;
			if (diff >= 0)
			{
				for (var i:int = 0; i < diff; i++)
				{
					tmp = new ZingDigit();
					_ref.push(tmp);
					tmp.x = (oldLength + i) * 20;
					addChild(tmp);
				}
			}
			else
			{
				diff = RookieMath.abs(diff);
				for (var j:int = 0; j < diff; j++)
				{
					tmp = _ref.pop();
					removeChild(tmp);
				}
			}
		}
	}
}
import flash.display.MovieClip;
import flash.display.Sprite;

class ZingDigit extends Sprite
{
	private var _mc:MovieClip;
	private var _val:uint;
	
	public function ZingDigit()
	{
		_mc = new digit();
		addChild(_mc);
	}
	
	public function set val(val:uint):void
	{
		_val = val;
		_mc.gotoAndStop(val + 1);
	}
	
	public function get val():uint
	{
		return _val;
	}
}