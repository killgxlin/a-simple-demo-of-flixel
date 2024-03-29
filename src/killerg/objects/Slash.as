package killerg.objects 
{
	import killerg.*;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	import org.flixel.plugin.photonstorm.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class Slash extends BaseObj implements Weapon
	{
		public var parent:Character = null;
		
		private var _hurtChars:Vector.<Character> = new Vector.<Character>;
		
		private var _damage:int = 0;
		
		private var _oriOffset:FlxPoint = new FlxPoint;
		
		private var _oriWidth:uint = 0;
		
		private var _oriHeight:uint = 0;
		
		final protected function adaptScale(Scale:FlxPoint):void 
		{
			this.offset.copyFrom(_oriOffset);
			this.width = _oriWidth;
			this.height = _oriHeight;
			
			this.scale.x = Scale.x
			this.scale.y = Scale.y

			this.offset.x=this.offset.x + Math.floor(this.width  * -(this.scale.x - 1)/2);
			this.offset.y=this.offset.y + Math.floor(this.height * -(this.scale.y - 1)/2);
		
			this.width= this.width  * (this.scale.x);
			this.height=this.height * (this.scale.y);
		}

		public function Slash() 
		{
			super();
			
			loadGraphic(Resource.ImgSlash, true, false, 16, 16, false);
			addAnimation("launch", [0, 1, 2, 3, 4], 20, false);
			addAnimationCallback(function(Name:String, Num:uint, Idx:uint):void {
				if (Idx == 4) 
				{
				 kill();
				 _hurtChars.splice(0, _hurtChars.length);
				}
			});
			
			_oriOffset.copyFrom(this.offset);
			_oriWidth = this.width;
			_oriHeight = this.height;
			
			this.exists = false;
		}
		
		public function launch(Owner:Character, Args:Object = null):Boolean 
		{
			this.parent = Owner;
			
			reset(0, 0);
			
			adaptScale(Args.Scale);	

			if (parent.facing == LEFT) 
			{
				this.x = parent.x - this.width;
				this.facing = LEFT;
				this.angle = 180 - Args.Angle;
			}
			
			if (parent.facing == RIGHT) 
			{
				this.x = parent.x + parent.width;
				this.facing = RIGHT;
				this.angle =  Args.Angle;
			}

			this.y = parent.y
			
			
			this.velocity.x = 0;
			this.velocity.y = 0;
			
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			
			this.moves = true;
			this.immovable = false;
			
			this._damage = Args.Damage;
			
			play("launch", true);
			
			return true;
		}
		
		override public function update():void 
		{
			super.update();

			if (parent.facing == LEFT) 
			{
				this.x = parent.x - this.width;
				this.facing = LEFT;
			
			}
			if (parent.facing == RIGHT) 
			{
				this.x = parent.x + parent.width;
				this.facing = RIGHT;
			}
			
			this.y = parent.y
		}
		
		public function hitMap(Map:FlxTilemap):void 
		{
			
		}
		
		public function hitChar(Char:Character):void 
		{
			if (Char != this.parent && this._hurtChars.indexOf(Char) == INVALID) 
			{
				if (FlxCollision.pixelPerfectCheck(this, Char)) 
				{
					Char.hurt(this._damage);
					this._hurtChars.push(Char);
				}
			}
		}
		
	}

}