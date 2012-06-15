package killerg
{
	import org.flixel.*;
	import killerg.*;
	import killerg.objects.*;
	import killerg.goals.atomic.*;
	/**
	 * ...
	 * @author killerg
	 */
	public class PlayState extends FlxState 
	{
		public var weapon_rm:Vector.<BaseObj> = new Vector.<BaseObj>
	
		override public function create():void
		{
			Registry.init();
			Registry.addToState(FlxG.state);

			Registry.map.loadMap(new Resource.CsvTilesData, Resource.ImgTiles, 16);
			Registry.chars.spawn(Registry.map.getMidpoint().x + 20, Registry.map.getMidpoint().y, 16, GoalAICtrl);
			Registry.player = Registry.chars.spawn(Registry.map.getMidpoint().x, Registry.map.getMidpoint().y, 0, GoalKBCtrl1);
			
			FlxG.camera.follow(Registry.player);
			FlxG.worldBounds = Registry.map.getBounds();
			FlxG.camera.bounds = FlxG.worldBounds;
		}
		
		override public function update():void 
		{
			globalControl();
			
			super.update();
			
			FlxG.collide(Registry.chars);
			FlxG.collide(Registry.chars, Registry.map);
			
			FlxG.collide(Registry.weapons, Registry.map, Registry.weapons.hitMap);
			FlxG.overlap(Registry.weapons, Registry.chars, Registry.weapons.hitChar);
		}
		
		private function globalControl():void 
		{
			if (FlxG.keys.justPressed("Y")) 
			{
				FlxG.visualDebug = !FlxG.visualDebug;
			}
			if (FlxG.keys.justPressed("S")) 
			{
				Registry.chars.spawn(Registry.player.getMidpoint().x + 20, Registry.player.getMidpoint().y, 16, GoalAICtrl);
			}
			if (FlxG.keys.justPressed("W")) 
			{
				Registry.chars.spawn(Registry.map.getMidpoint().x, Registry.map.getMidpoint().y, 207, GoalPursueFly);
			}
			if (FlxG.keys.justPressed("D")) 
			{
				Registry.player = Registry.chars.spawn(Registry.player.x, Registry.player.y, 0, GoalKBCtrl1);
			}
		}
	}

} 