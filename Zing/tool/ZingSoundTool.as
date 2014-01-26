package tool 
{
	import define.ZingEleEnum;
	import define.ZingSoundEnum;
	import flash.media.Sound;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingSoundTool 
	{	
		public static function playSoundEff(type:int):void
		{
			var sound:Sound;
			switch(type)
			{
				case ZingSoundEnum.BOMB:
					sound = new soundExplode();
					sound.play(0, 1);
					break;
				case ZingSoundEnum.BONUS:
					sound = new soundShine();
					sound.play(0, 1);
					break;
				case ZingSoundEnum.CLOCK:
					sound = new soundShine();
					sound.play(0, 1);
					break;
				case ZingSoundEnum.TARGET:
					sound = new soundTarget();
					sound.play(0, 1);
					break;
				case ZingSoundEnum.CROSS:
					sound = new soundCross();
					sound.play(0, 1);
					break;
				case ZingSoundEnum.OVER:
					sound = new soundOver();
					sound.play(0, 1);
					break;
				case ZingSoundEnum.PASS:
					sound = new soundPass();
					sound.play(0, 1);
			}
		}
	}
}