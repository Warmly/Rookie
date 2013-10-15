package global
{
	import flash.utils.Endian;

	import core.creature.DetailedNpcVO;

	import flash.utils.Dictionary;

	import definition.Define;

	import flash.utils.ByteArray;

	import global.ModelBase;

	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Warmly
	 */
	public class StaticDataModel extends ModelBase
	{
		public var Action:XML;
		public var detailedNpcDic:Dictionary = new Dictionary();

		public function StaticDataModel()
		{
			super();
			initXML();
			initTable();
		}

		private function initTable():void
		{
			parseTable("NpcBase", DetailedNpcVO, detailedNpcDic);
		}

		private function parseTable(name:String, voType:Class, dic:Dictionary):void
		{
			var tableCls:Class = getDefinitionByName("Table_StaticData_" + name) as Class;
			var table:ByteArray = new tableCls();
			table.endian = Endian.LITTLE_ENDIAN;

			var byteArr:ByteArray = new ByteArray();
			byteArr.endian = Endian.LITTLE_ENDIAN;
			byteArr.writeBytes(table);
			byteArr.position = 0;

			var flag:uint = byteArr.readUnsignedInt();
			var fieldNum:uint = byteArr.readUnsignedInt();
			var recordNum:uint = byteArr.readUnsignedInt();
			var dataSize:uint = byteArr.readUnsignedInt();

			for (var i:uint = 0;i < recordNum;i++)
			{
				var vo:ParseableVO = new voType(byteArr);
				dic[vo.id] = vo;
			}
		}

		private function initXML():void
		{
			var xmlCls:Class = getDefinitionByName("Config_StaticData") as Class;
			var xml:* = new xmlCls();
			var description:XML = describeType(xml);
			var nameList:XMLList = description..variable;
			for each (var i : XML in nameList)
			{
				var name:String = i.@name;
				if (name == "Action")
				{
					var subXmlStr:String = parseUtfToGb2312(name);
					this[name] = new XML(subXmlStr);
				}
			}
		}

		private function parseUtfToGb2312(str:String):String
		{
			var subXmlCls:Class = getDefinitionByName("Config_StaticData_" + str)as Class;
			var subXml:ByteArray = new subXmlCls();
			var result:String = subXml.readMultiByte(subXml.length, Define.CHARSET);
			return result;
		}
	}
}
