package killerg.goals.atomic
{
	import killerg.objects.Character;
	import killerg.TouchPad;
	import org.flixel.*;
	/**
	 * ...
	 * @author killerg
	 */
	public class GoalKBCtrl2 extends Goal 
	{
		private var pad:TouchPad;
		public function GoalKBCtrl2(theObj:Character):void 
		{
			super(theObj);
			pad = new TouchPad;
			FlxG.state.add(pad);
		}
		
		override public function activate():void 
		{
			_status = ACTIVE;
		}
		
		override public function process():int 
		{
			activateIfInactive();
			if (_status != ACTIVE)  return _status;
			
			if (pad.left) 
			{
				GetChar().run(FlxObject.LEFT);
			}
			if (pad.right) 
			{
				GetChar().run(FlxObject.RIGHT);
			}
			if ( pad.jump)
			{
				GetChar().jump();
			}
			
			if (FlxG.keys.justPressed("COMMA")) 
			{
				GetChar().fire(0);
			}
			if (FlxG.keys.justPressed("PERIOD")) 
			{
				GetChar().fire(1);
			}
			if (FlxG.keys.justPressed("SLASH")) 
			{
				GetChar().fire(2);
			}		
			
			return _status;
		}
		
	}

}