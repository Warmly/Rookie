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
	     * 屏幕像素坐标到场景像素坐标
	     */
		public static function cameraToScene(x:Number, y:Number):Point
		{
			var camera:SanguoCamera = SanguoEntry.camera;
			return new Point(x + camera.xInScene, y + camera.yInScene);
		}
		
		/**
	     * 场景像素坐标到场景格子坐标
	     */
		public static function sceneToCell(x:Number, y:Number):Point
		{
			var cellX:int = RookieMath.floor(x / MapModel.CELL_WIDTH);
			var cellY:int = RookieMath.floor(y / MapModel.CELL_HEIGHT);
			return new Point(cellX, cellY);
		}
		
		/**
	     * 屏幕像素坐标到场景格子坐标
	     */
		public static function cameraToCell(x:Number, y:Number):Point
		{
			var sceneCoor:Point = cameraToScene(x, y);
			var cellCoor:Point = sceneToCell(sceneCoor.x, sceneCoor.y);
			return cellCoor;
		}
		
		/**
	     * 场景格子坐标到场景像素坐标(格子中心点)
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
	     * 屏幕像素坐标到实际场景坐标(格子中心点)
	     */
		public static function cameraToSceneValid(x:Number, y:Number):Point
		{
			var cellCoor:Point = cameraToCell(x, y);
			var validCoor:Point = cellToScene(cellCoor.x, cellCoor.y);
			return validCoor;
		}
		
		/**
	     * 计算格子距离
	     */
		public static function calCellDictance(x1:int, y1:int, x2:int, y2:int):int
		{
			var disX:int = RookieMath.abs(x1 - x2);
			var disY:int = RookieMath.abs(y1 - y2);
			return Math.max(disX, disY);
		}
		
		/**
	     * 场景像素坐标到屏幕像素坐标
	     */
		public static function sceneToCamera(x:Number, y:Number):Point
		{
			var camera:SanguoCamera = SanguoEntry.camera;
			return new Point(x - camera.xInScene, y - camera.yInScene);
		}
	}
}