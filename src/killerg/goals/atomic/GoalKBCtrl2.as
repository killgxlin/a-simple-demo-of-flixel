package killerg.goals.atomic
{
	import org.flixel.*;
	/**
	 * ...
	 * @author killerg
	 */
	public class GoalKBCtrl2 extends Goal 
	{
		public function GoalKBCtrl2(theObj:Character):void 
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
			if (_status != ACTIVE)  return _status;
			
			if (FlxG.keys.LEFT) 
			{
				_theObj.run(FlxObject.LEFT);
			}
			if (FlxG.keys.RIGHT) 
			{
				_theObj.run(FlxObject.RIGHT);
			}
			if ( FlxG.keys.UP && _theObj.isTouching(FlxObject.FLOOR))
			{
				_theObj.jump();
			}
			
			if (FlxG.keys.justPressed("COMMA")) 
			{
				_theObj.fire(0);
			}
			if (FlxG.keys.justPressed("PERIOD")) 
			{
				_theObj.fire(1);
			}
			if (FlxG.keys.justPressed("SLASH")) 
			{
				_theObj.fire(2);
			}		
			
			return _status;
		}
		
	}

}