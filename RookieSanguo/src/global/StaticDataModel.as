package global
{
	import config.XmlConfigVO;
	import core.creature.NpcConfigVO;
	import flash.utils.CompressionAlgorithm;
	import res.FileVO;
	import rookie.core.resource.ResUrl;
	import rookie.global.RookieEntry;

	import definition.Define;

	import rookie.dataStruct.HashTable;

	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Warmly
	 */
	public class StaticDataModel extends ModelBase
	{
		public var Action:XML;
		public var sceneMapInfoConfig:XML;
		private var _npcConfig:HashTable = new HashTable(uint, NpcConfigVO);
		private var _xmlConfig:HashTable = new HashTable(String, XmlConfigVO);
		private var _fileVOTable:HashTable = new HashTable(String, FileVO);
		private var _configFileData:ByteArray;

		public function StaticDataModel()
		{
			super();
			initXML();
			initTable();
		}
		
		public function getNpcConfigVO(staticId:uint):NpcConfigVO
		{
			return _npcConfig.search(staticId);
		}
		
		public function getXmlConfig(name:String):XML
		{
			name = name.toLowerCase();
			if (!_xmlConfig.has(name))
			{
				var vo:FileVO = _fileVOTable.search(name);
				if (vo)
				{
					var byteArr:ByteArray = new ByteArray();
					byteArr.endian = Endian.LITTLE_ENDIAN;
					byteArr.writeBytes(_configFileData, vo.offset, vo.lengthAfterCompress);
					//byteArr.uncompress(CompressionAlgorithm.LZMA);
					byteArr.position = 0;
					var xml:XML = new XML(byteArr.readMultiByte(byteArr.length, Define.CHARSET));
					var xmlVO:XmlConfigVO = new XmlConfigVO(name, xml);
					_xmlConfig.insert(name, xmlVO);
					return xml;
				}
				else
				{
					Error("未找到名为" + name + "的配置！");
				}
			}
			return _xmlConfig.search(name);
		}

		private function initTable():void
		{
			parseTable("NpcBase", NpcConfigVO, _npcConfig);
		}

		private function parseTable(name:String, voType:Class, cfg:HashTable):void
		{
			var tableCls:Class = getDefinitionByName("Table_StaticData_" + name) as Class;
			var table:ByteArray = new tableCls();
			table.endian = Endian.LITTLE_ENDIAN;
			table.position = 0;

			var flag:uint = table.readUnsignedInt();
			var fieldNum:uint = table.readUnsignedInt();
			var recordNum:uint = table.readUnsignedInt();
			var dataSize:uint = table.readUnsignedInt();

			for (var i:uint = 0;i < recordNum;i++)
			{
				var vo:ParseableVO = new voType(table);
				cfg.insert(vo.id , vo);
			}
		}
		
		private function initXML():void
		{
			var byteArr:ByteArray = RookieEntry.resManager.byteArrData.search(SanguoGlobal.CONFIG_RES_URL.url);
			byteArr.endian = Endian.LITTLE_ENDIAN;
            
			//解析头部
			var version:int = byteArr.readUnsignedByte();
			var compressType:int = byteArr.readUnsignedByte();
			//不包含头部
			var lengthBeforeCompress:int = byteArr.readUnsignedInt();
			var lengthAfterCompress:int = byteArr.readUnsignedInt();
			
			var byteArrWithoutHead:ByteArray = new ByteArray();
			byteArrWithoutHead.endian = Endian.LITTLE_ENDIAN;
			byteArrWithoutHead.writeBytes(byteArr, byteArr.position);
			byteArrWithoutHead.uncompress(CompressionAlgorithm.LZMA);
			byteArrWithoutHead.position = 0;
			_configFileData = byteArrWithoutHead;
			
			var version1:int = byteArrWithoutHead.readUnsignedByte();
			var compressType1:int = byteArrWithoutHead.readUnsignedByte();
			var fileNum:int = byteArrWithoutHead.readUnsignedShort();
			var lengthBeforeCompress1:int = byteArrWithoutHead.readUnsignedInt();
			var lengthAfterCompress1:int = byteArrWithoutHead.readUnsignedInt();
			
			for (var i:int = 0; i < fileNum; i++)
			{
				var vo:FileVO = new FileVO(byteArrWithoutHead);
				_fileVOTable.insert(vo.name, vo);
			}
		}

		private function initOldXML():void
		{
			var xmlCls:Class = getDefinitionByName("Config_StaticData") as Class;
			var xml:* = new xmlCls();
			var description:XML = describeType(xml);
			var nameList:XMLList = description..variable;
			for each (var i : XML in nameList)
			{
				var name:String = i.@name;
				if (name == "Action" || name == "sceneMapInfoConfig")
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
