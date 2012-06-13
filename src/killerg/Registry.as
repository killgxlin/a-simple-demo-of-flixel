package killerg
{
	import org.flixel.*;
	import killerg.*;
	import killerg.objects.*;
	import killerg.managers.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class Registry extends FlxGroup
	{
		
		public static var chars:CharacterMgr;
		public static var arrows:ArrowMgr;
		public static var map:FlxTilemap;
		public static var player:Character;
		public static var bloods:BloodMgr;
		
		static public function init():void 
		{
			map = new FlxTilemap;
			chars = new CharacterMgr;
			arrows = new ArrowMgr;
			bloods = new BloodMgr;
		}
		
		static public function addToState(state:FlxState):void 
		{
			state.add(map);
			state.add(chars);
			state.add(arrows);
			state.add(bloods);
		}
		
		static public function destroy():void 
		{
			chars.destroy();
			chars = null;
			
			arrows.destroy();
			arrows = null;
						
			map = null;
			player = null;
			
			bloods.destroy();
			bloods = null;
		}
	}

}