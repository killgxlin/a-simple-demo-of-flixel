package killerg.objects 
{
	import killerg.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class Slash extends BaseObj
	{
		public var _owner:Character = null;
		public const LAST_TIME:Number = 0.5;
		protected var _liveTimer:FlxDelay = null;
		public var _hurtChars:Vector.<Character> = null;;
		
		public function Slash() 
		{
			 super();
			 loadGraphic(Resource.ImgSlash, true, true, 16, 16, false);
			 addAnimation("launch", [0, 1, 2, 3, 4], 5/LAST_TIME, true);		
			 _liveTimer = new FlxDelay(0);
			 _hurtChars = new Vector.<Character>;
			 exists = false;
		}
		
		public function launch(Owner:Character):void 
		{
			_owner = Owner;
			reset(0, 0);
			
			this.y = _owner.getMidpoint().y;
			this.x = _owner.getMidpoint().x;
			
			this.velocity.x = 0;
			this.velocity.y = 0;
			
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			
			this.moves = true;
			this.immovable = false;
			
			this._liveTimer.reset(LAST_TIME);
			play("launch", true);
		}
		
		override public function update():void 
		{
			super.update();
			x = _owner.getMidpoint().x;
			y = _owner.getMidpoint().y;
			
			if (this._liveTimer.hasExpired) 
			{
				//kill();
			}
			_hurtChars.splice(0, _hurtChars.length);
		}
		
		public function overlap(Obj:Character, Slh:Slash):void 
		{
			if (Obj == Slh._owner)  return;
			
			//if (Slh._hurtChars.indexOf(Obj) == INVALID) 
			{
				Obj.hurt(1);
			//	Slh._hurtChars.push(Obj);				
			}
		}
	}

}