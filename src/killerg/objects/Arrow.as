package killerg.objects
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	import killerg.*;
	import killerg.goals.atomic.*;
	import killerg.objects.*;
	
	
	/**
	 * ...
	 * @author killerg
	 */
	public class Arrow extends BaseObj 
	{

		private var liveTimer:FlxDelay;
		public var owner:Character = null;
		
		public function Arrow() 
		{
			super(0, 0, Resource.ImgArrow);
			maxVelocity.make(300, 100);
			acceleration.make(0, 200);
			exists = false;
			this.liveTimer = new FlxDelay(0);
		}
		
		override public function destroy():void 
		{
			super.destroy();
			this.liveTimer = null;
			this.owner = null;
		}
		
		public function fire(char:Character, idx:int):void 
		{
			this.reset(0, 0);
			
			switch(idx)
			{
				case 0:
					this.velocity.make(300, -50);
					break;
				case 1:
					this.velocity.make(200, -200);
					addEffect(new GoalLargeSight(this));
					break;
				case 2:
					this.velocity.make(100, -300);
					
					if (FlxMath.vectorLength(char.x - Registry.player.x, char.y-Registry.player.y) > 40) 
					{
						addEffect(new GoalPursueFly(this));
					}
					
					break;
				default:
					this.velocity.make(0, 0);
					break;
			}
			
			if (char.facing == LEFT) 
			{
				this.velocity.x *= -1;
			}
			else if (char.facing == RIGHT) 
			{

			}
			
			this.x = char.x
			this.y = char.y + 3;			
			this.owner = char;
			
			this.moves = true;
			this.immovable = false;
			
			this.liveTimer.reset(Resource.ARROW_LIVE);
		}
		
		override public function update():void 
		{
			super.update();

			if (velocity.x != 0 && velocity.y != 0) 
			{
				angle = FlxU.getAngle(velocity, ZEROVECTOR ) + 90;
			}
			
			if (liveTimer.hasExpired)
			{
				kill();
			}
		}
		
		public function stop():void 
		{
			this.immovable = true;
			this.moves = false;
		}
		
	}

}