package killerg.managers
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import killerg.objects.*;
	import killerg.*;
	import killerg.goals.atomic.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class WeaponMgr extends FlxGroup 
	{
		private var _cache:Object = {"Arrow":new FlxGroup, "Slash":new FlxGroup}
		
		public function WeaponMgr() 
		{

			for (var i:int = 0; i < Resource.ARROW_NUM; ++i)
			{
				var arrow:Arrow = new Arrow;
				
				_cache.Arrow.add(arrow);
				add(arrow);
			}
			
			for (var j:int = 0; j < Resource.SLASH_NUM; j++) 
			{
				var slash:Slash = new Slash;
				
				_cache.Slash.add(slash);
				add(slash);
			}
		}
		
		public function hitChar(Weap:Weapon,char:Character):void 
		{
			Weap.hitChar(char);
		}

		public function hitMap(Weap:Weapon, map:FlxTilemap):void 
		{
			Weap.hitMap(map);
		}
		
		public function launch(Char:Character, Args:Object):Boolean 
		{
			var array:FlxGroup = _cache[Args.Type];

			if (array == null || array.getFirstAvailable() == null)  return false;			
			
			return (array.getFirstAvailable() as Weapon).launch(Char, Args);
		}

		public function getArrowTemplete(Action:Class = null):Object 
		{
			return { "Type":"Arrow", "Angle":40 + FlxMath.randFloat( -2, 2), "Vel":150, "Gravity":150, "Damage":10, "Goal":Action };
		}
		
		public function getSlashTemplete():Object 
		{
			return { "Type":"Slash", "Angle":180, "Scope":20, "Damage":10, "Scale":new FlxPoint(.5, .5) };
		}

		public function getSlashTemplete2():Object 
		{
			return { "Type":"Slash", "Angle":-45, "Scope":20, "Damage":10, "Scale":new FlxPoint(.5, .5) };
		}
	}
}