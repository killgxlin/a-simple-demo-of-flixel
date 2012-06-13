package killerg.goals.atomic
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import killerg.*;
	import killerg.objects.*;

	/**
	 * ...
	 * @author killerg
	 */
	public class GoalAICtrl extends Goal 
	{
		private var moveTimer:FlxTimer;
		private var dir:uint = FlxObject.LEFT;
		
		public function GoalAICtrl(theObj:Character):void 
		{
			super(theObj);
			moveTimer = new FlxTimer;
			moveTimer.start(1, 1, moveExpire);
		}
		
		override public function activate():void 
		{
			_status = ACTIVE;
		}
		override public function process():int 
		{
			activateIfInactive();
			if (_status != ACTIVE) return _status;
			
			GetBaseObj().acceleration.x = 0;
			
			if (GetChar().isTouching(FlxObject.WALL)) 
			{
				dir = dir == FlxObject.LEFT ? FlxObject.RIGHT : FlxObject.LEFT;
			}
			else
			{
				moveTimer.update();
			}
			GetChar().run(dir);
			
			if (FlxMath.chanceRoll(1)) 
			{
				GetChar().fire(2);
			}

			return _status;
		}
		
		private function moveExpire(timer:FlxTimer):void 
		{
			timer.start(Math.random() * 2, 1, moveExpire);
			dir = Math.random() > 0.5 ? FlxObject.LEFT : FlxObject.RIGHT;			
		}
		
	}

}