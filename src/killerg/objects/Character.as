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
			exists = false;
			super.loadGraphic(Resource.ImgChar, true, true, 8, 8);
			
		}
		
		public function init(x:int, y:int, idx:int = 0, ctrl:Class = null):void 
		{
			reset(x, y);
			
			_animations.splice(0, _animations.length);
			
			addAnimation("run", [idx]);
			addAnimation("jump", [idx]);
			addAnimation("idle", [idx]);
			addAnimation("fall", [idx]);
		

			
			acceleration.make(0, 400);
			drag.make(800, 800);
			maxVelocity.make(100, 200);
			
			health = 2;
			
			if (ctrl != null) 
			{
				setAction(new ctrl(this));
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
		
		public function run(dir:uint):void 
		{
			facing = dir;
			if (dir == LEFT) 
			{
				acceleration.x += -drag.x;
			}
			else if (dir == RIGHT) 
			{
				acceleration.x += drag.x;
			}
		}
		
		public function jump(big:Boolean = false):void 
		{
			if (isTouching(FLOOR)) 
			{
				velocity.y = -(big?170:120);
			}
		}
		
		public function fire(idx:uint):void 
		{
			Registry.arrows.fire(this, idx);
		}
	}

}