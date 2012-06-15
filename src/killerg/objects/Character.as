package killerg.objects
{
	import org.flixel.*;
	import killerg.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class Character extends BaseObj
	{
		private var _walk:int = 0;
				
		public function Character() 
		{
			super();
			loadGraphic(Resource.ImgChar, true, true, 8, 8);

			exists = false;
		}
		
		public function init(X:int, Y:int, GraphicIdx:int = 0, Ctrl:Class = null):void 
		{
			reset(X, Y);
			
			_animations.splice(0, _animations.length);
			
			addAnimation("run", [GraphicIdx]);
			addAnimation("jump", [GraphicIdx]);
			addAnimation("idle", [GraphicIdx]);
			addAnimation("fall", [GraphicIdx]);

			
			acceleration.make(0, 400);
			drag.make(800, 800);
			maxVelocity.make(100, 200);
			
			health = 20;
			
			if (Ctrl != null) 
			{
				setAction(new Ctrl(this));
			}			
			
			super.flicker(1);
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
		override public function update():void 
		{	
			acceleration.x = 0;

			super.update();
			
			if (velocity.x != 0) 
			{
				if (velocity.y > 0) 
				{
					play("fall");
				}
				else if (velocity.y < 0)
				{
					play("jump");
				}
				else
				{
					play("run");
				}
			}
			if (velocity.x == 0 && velocity.y == 0) 
			{
				play("idle");
			}
		}
		override public function draw():void 
		{
			if (_curAnim == null) return;
						
			if (_curAnim.name == "run") 
			{
				var oldy:uint = y;
				y -= (_walk++ % 2 + 1);
				super.draw();
				y = oldy;
			}
			else
			{
				super.draw();
			}

		}
		
		override public function hurt(Damage:Number):void 
		{
			if (flickering)  return;
			
			super.hurt(Damage);
			Registry.bloods.bleed(this);		
		}
		
		public function run(Dir:uint):void 
		{
			facing = Dir;
			if (Dir == LEFT) 
			{
				acceleration.x += -drag.x;
			}
			else if (Dir == RIGHT) 
			{
				acceleration.x += drag.x;
			}
		}
		
		public function jump():void 
		{
			if (isTouching(FLOOR)) 
			{
				velocity.y = -((170-120) * (1-( maxVelocity.x - Math.abs(velocity.x) ) / maxVelocity.x) + 120)
			}
		}
		
		public function fire(Idx:uint):void 
		{
			switch (Idx) 
			{
				case 0:
					Registry.weapons.launch(this, Registry.weapons.getArrowTemplete());
					break;
				case 1:
					Registry.weapons.launch(this, Registry.weapons.getArrowTemplete());
					break;
				case 2:
					Registry.weapons.launch(this, Registry.weapons.getSlashTemplete());
					break;
				default:
					break;
			}

		}
	}

}