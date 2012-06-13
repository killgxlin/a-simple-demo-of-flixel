package killerg.goals.atomic
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import killerg.*;
	import killerg.objects.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class GoalKBCtrl1 extends Goal
	{
		public function GoalKBCtrl1(theObj:Character):void 
		{
			super(theObj);
		}
		override public function activate():void 
		{
			_status = ACTIVE;
		}
		override public function process():int 
		{
			activateIfInactive();
			if (_status != ACTIVE) return _status;
					
			if (FlxG.keys.F && !FlxG.keys.G) 
			{
				GetChar().run(FlxObject.LEFT);
			}
			if (FlxG.keys.G && !FlxG.keys.F) 
			{
				GetChar().run(FlxObject.RIGHT);
			}
			
			if ( FlxG.keys.justPressed("T") )
			{
				GetChar().jump(FlxG.keys.R);
			}
			
			if (FlxG.keys.justPressed("Z")) 
			{
				GetChar().fire(0);
			}
			if (FlxG.keys.justPressed("X")) 
			{
				GetChar().fire(1);
			}
			if (FlxG.keys.justPressed("C")) 
			{
				GetChar().fire(2);
			}
			if (FlxG.keys.justPressed("A")) 
			{
				Registry.bloods.bleed(GetChar());
			}
			
			return _status;
		}
		
	}

}