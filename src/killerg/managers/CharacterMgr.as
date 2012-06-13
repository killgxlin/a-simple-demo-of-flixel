package killerg.managers
{
	import org.flixel.FlxGroup;
	import killerg.objects.*;
	import killerg.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class CharacterMgr extends FlxGroup 
	{
		public function CharacterMgr() 
		{
			for (var i:int = 0; i < Resource.CHARACTER_NUM; i++) 
			{
				add(new Character);
			}
		}
		
		public function spawn(x:int, y:int, idx:int = 0, ctrl:Class = null):Character 
		{
			var char:Character = (getFirstAvailable() as Character);
			
			if (char != null) 
			{
				char.init(x, y, idx, ctrl);
			}
			
			return char;
		}
	}

}