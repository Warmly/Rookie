package tool 
{
	import core.scene.MapModel;
	import core.scene.SanguoCamera;
	import flash.geom.Point;
	import global.SanguoEntry;
	import rookie.tool.math.RookieMath;
	/**
	 * 三国坐标转换工具
	 * @author Warmly
	 */
	public class SanguoCoorTool 
	{
		/**
	     * 屏幕坐标到场景坐标
	     */
		public static function cameraToScene(x:Number, y:Number):Point
		{
			var camera:SanguoCamera = SanguoEntry.camera;
			return new Point(x + camera.xInScene, y + camera.yInScene);
		}
		
		/**
	     * 屏幕坐标到场景格子坐标
	     */
		public static function cameraToCell(x:Number, y:Number):Point
		{
			var sceneCoor:Point = cameraToScene(x, y);
			var cellX:int = RookieMath.floor(sceneCoor.x / MapModel.CELL_WIDTH);
			var cellY:int = RookieMath.floor(sceneCoor.y / MapModel.CELL_HEIGHT);
			return new Point(cellX, cellY);
		}
		
		/**
	     * 场景格子坐标到场景坐标
	     */
		public static function cellToScene(cellX:int, cellY:int):Point
		{
			var coorX:Number = cellX * MapModel.CELL_WIDTH;
			var coorY:Number = cellY * MapModel.CELL_HEIGHT;
			coorX += MapModel.CELL_WIDTH * 0.5;
			coorY += MapModel.CELL_HEIGHT * 0.5;
			return new Point(coorX, coorY);
		}
		
		/**
	     * 屏幕坐标到实际场景坐标(格子中心点)
	     */
		public static function cameraToSceneValid(x:Number, y:Number):Point
		{
			var cellCoor:Point = cameraToCell(x, y);
			var validCoor:Point = cellToScene(cellCoor.x, cellCoor.y);
			return validCoor;
		}
	}
}