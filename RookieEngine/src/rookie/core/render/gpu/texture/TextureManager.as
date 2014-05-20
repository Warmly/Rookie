package rookie.core.render.gpu.texture 
{
	import flash.utils.Dictionary;
	import rookie.core.IMainLoop;
	import rookie.core.render.gpu.base.RookieTexture;
	import rookie.core.render.RenderInfo;
	import rookie.core.time.SysTimeManager;
	import rookie.dataStruct.HashTable;
	/**
	 * 贴图管理，释放
	 * @author Warmly
	 */
	public class TextureManager implements IMainLoop
	{
		private var _textureTable:HashTable = new HashTable(String, RookieTexture);
		
		public function TextureManager() 
		{
		}
		
		public function addToCache(texture:RookieTexture):void
		{
			if (!_textureTable.has(texture.name))
			{
				_textureTable.insert(texture.name, texture);
			}
		}
		
		public function getTexture(name:String):RookieTexture
		{
			return _textureTable.search(name) as RookieTexture;
		}
		
		public function onEnterFrame():void
		{
			var items:Dictionary = _textureTable.content;
			for each (var item:RookieTexture in items) 
			{
				if (SysTimeManager.sysTime - item.lastUsedTime >= RenderInfo.TEXTURE_DISPOSE_LIMIT_TIME)
				{
					item.dispose();
					_textureTable.del(item.name);
				}
			}
		}
	}
}