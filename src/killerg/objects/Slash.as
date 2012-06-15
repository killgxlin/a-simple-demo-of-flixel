package killerg.objects 
{
	import killerg.*;
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
			
			this.exists = false;
		}
		
		public function launch(Owner:Character, Args:Object = null):Boolean 
		{
			this.parent = Owner;
			
			reset(0, 0);
			
			this.height = parent.height;
			this.width = parent.width;
			
			if (parent.facing == LEFT) 
			{
				this.x = parent.x - this.width;
				this.facing = LEFT;
				this.angle = 270-Args.Angle;
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
			
			this.scale.make(.5, .5);
			this.offset.make( this.width/2, this.height/2);
			
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