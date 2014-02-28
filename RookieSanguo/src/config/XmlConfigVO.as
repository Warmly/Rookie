package config 
{
	/**
	 * ...
	 * @author Warmly
	 */
	public class XmlConfigVO 
	{
		private var _name:String;
		private var _xml:XML;
		
		public function XmlConfigVO(name:String, xml:XML) 
		{
			_name = name;
			_xml = xml;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get xml():XML
		{
			return _xml;
		}
	}
}