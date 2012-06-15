package killerg.goals.atomic 
{
	import org.flixel.*;
	import killerg.goals.atomic.*;
	import killerg.objects.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class GoalLargeSight extends Goal
	{
		private var initScale:FlxPoint;
		
		public function GoalLargeSight(arrow:Arrow) 
		{
			super(arrow);
			initScale = new FlxPoint;
			FlxG.camera.zoom = 1;
		}
		
		override public function activate():void 
		{
			initScale.copyFrom(FlxG.camera.getScale());
			FlxG.camera.follow(GetWeapon());
			_status = ACTIVE;
		}
		
		override public function process():int 
		{
			activateIfInactive();
			return _status;
		}
	
		override public function terminate():void 
		{
			FlxG.camera.follow(GetWeapon().parent);
			FlxG.camera.setScale(initScale.x, initScale.y);
			FlxG.camera.zoom = 2;
		}
	}

}