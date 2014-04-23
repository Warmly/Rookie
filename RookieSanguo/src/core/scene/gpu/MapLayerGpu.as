package core.scene.gpu 
{
	import core.scene.MapModel;
	import global.ModelEntry;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MapLayerGpu 
	{
		private var _mapModel:MapModel;
		// 水平
		private var _numBlockW:int;
		// 竖直
		private var _numBlockH:int;
		private var _block:Vector.<MapBlockGpu> = new Vector.<MapBlockGpu>();
		
		public function MapLayerGpu() 
		{
			_mapModel = ModelEntry.mapModel;
		}
		
		
	}
}