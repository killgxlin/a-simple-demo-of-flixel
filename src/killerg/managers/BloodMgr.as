package killerg.managers 
{
	import org.flixel.*;
	import killerg.objects.*;
	import killerg.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class BloodMgr extends FlxGroup 
	{
		public function BloodMgr() 
		{
			for (var i:int = 0; i < Resource.BLOOD_NUM; i++) 
			{
				add(new Blood);
			}
		}
		
		public function bleed(char:Character):void 
		{
			var blood:Blood = getFirstAvailable() as Blood;
			if (blood == null) return;
			
			blood.bleed(char);
		}
	}

}