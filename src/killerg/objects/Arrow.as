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
	public class Arrow extends BaseObj implements Weapon
	{

		public var parent:Character = null;

		private var _liveTimer:FlxDelay = new FlxDelay(Resource.ARROW_LIVE);
		
		private var _hit:Boolean = false;
		
		private var _damage:int = 0;
		
		
		public function Arrow() 
		{
			super(0, 0, Resource.ImgArrow);
			
			this.exists = false;
		}
		
		override public function destroy():void 
		{
			super.destroy();

			this.parent = null;
		}
		
		//{Angle:Number, Vel:Number = 150, Gravity:Number = 150}
		public function launch(Parent:Character, Args:Object = null):Boolean
		{
			if (Args == null)  return false;
			
			this.parent = Parent;
			
			this.reset(0, 0);

			this.moves = true;
			this.immovable = false;
			
			this._damage = Args.Damage;
			this._hit = false;
			this._liveTimer.abort();

			var maxVel:Number = Args.Vel * 2;
			this.maxVelocity.make(Args.Vel, Args.Vel);
			this.acceleration.make(0, Args.Gravity);

			var radian:Number = Args.Angle * Math.PI / 180;
			this.velocity.y = - Math.sin(radian) * Args.Vel;
			this.velocity.x = Math.cos(radian) * Args.Vel;
			this.y = Parent.y + 3;			
			
			if (Parent.facing == LEFT) 
			{
				this.velocity.x *= -1;
				this.x = Parent.x - 3;
			}
			else
			{
				this.x = Parent.x + 3;
			}
			
			if (Args.Goal != null) 
			{
				this.addEffect(new (Args.Goal)(this));
			}
		
			return true;
		}
		
		override public function update():void 
		{
			super.update();

			if (velocity.x != 0 && velocity.y != 0) 
			{
				angle = FlxU.getAngle(velocity, ZEROVECTOR ) + 90;
			}
			
			if (_hit && _liveTimer.hasExpired)
			{
				kill();
			}
		}
		
		public function onHit():void 
		{
			this._hit = true;
			this._liveTimer.reset(Resource.ARROW_LIVE);
			
			this.immovable = true;
			this.moves = false;
		}
		
		public function hitMap(Map:FlxTilemap):void 
		{
			onHit();
		}
		
		public function hitChar(Char:Character):void 
		{
			if (this.parent != Char && this._hit == false)
			{
				if (FlxCollision.pixelPerfectCheck(this, Char)) 
				{
					Char.hurt(this._damage);
					this.onHit();				
				}
			}
		}
	}

}