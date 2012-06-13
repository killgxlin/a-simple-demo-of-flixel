package killerg
{
	import org.flixel.*;
	import killerg.*;
	import killerg.goals.atomic.*;
	/**
	 * ...
	 * @author killerg
	 */
	public class PlayState extends FlxState 
	{
		
	
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
			super.update();
			
			FlxG.collide(Registry.chars);
			FlxG.collide(Registry.chars, Registry.map);
			
			FlxG.collide(Registry.arrows, Registry.map, Registry.arrows.hitMap);
			FlxG.overlap(Registry.arrows, Registry.chars, Registry.arrows.hitChar);
			
			if (FlxG.keys.justPressed("S")) 
			{
				Registry.chars.spawn(Registry.player.getMidpoint().x + 20, Registry.player.getMidpoint().y, 16, GoalPursueRun);
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