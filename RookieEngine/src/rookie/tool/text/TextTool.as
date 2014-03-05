package rookie.tool.text 
{
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author Warmly
	 */
	public class TextTool 
	{
		public function TextTool() 
		{
		}
		
		public static function getLightTextField(fixWidth:Number = 0, isCenter:Boolean = false, leading:Number = 4, defaultFilter:Boolean = true, font:String = ""):RookieTextField
		{
			var textfield:RookieTextField = new RookieTextField();
			textfield.mouseEnabled = false;
			textfield.selectable = false;
			var textFormat:TextFormat = new TextFormat();
			if (fixWidth)
			{
				textfield.wordWrap = true;
				textfield.width = fixWidth;
			}
			if (isCenter)
			{
				textFormat.align = TextFormatAlign.CENTER;
				textfield.autoSize = TextFieldAutoSize.CENTER;
			}
			else
			{
				textFormat.align = TextFormatAlign.LEFT;
				textfield.autoSize = TextFieldAutoSize.LEFT;
			}
			if (leading)
			{
				textFormat.leading = leading;
			}
			if (defaultFilter)
			{
				textfield.filters = [new GlowFilter(0x000000, 0.7, 2, 2, 17, 1, false, false)];
			}
			if (font)
			{
				textFormat.font = font;
			}
			textfield.defaultTextFormat = textFormat;
			return textfield;
		}
		
		public static function getHtmlText(content:String, colorStr:String = "#DCDCDC", size:int = 12):String
		{
			return "<font size='" + size + "' color='" + colorStr + "'>" + content + "</font>";
		}
	}
}