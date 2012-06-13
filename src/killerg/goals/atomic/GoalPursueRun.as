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
	public class GoalPursueRun extends Goal 
	{
		private var _target:Character = null;
		private var _jumps:int = 0;
		private var _dir:int = FlxObject.LEFT;
		
		static private const _SPEED:int = 200;
		static private const _INTERVAL:int = 200;
		
		public function GoalPursueRun(owner:BaseObj) 
		{
			super(owner);
		}
		
		override public function activate():void 
		{
			_target = Registry.player;
			_status = ACTIVE;
		}
		
		override public function process():int 
		{
			activateIfInactive();
			if (_status != ACTIVE) return _status;
			
			var srcPos:FlxPoint = GetChar().getMidpoint();
			var dstPos:FlxPoint = _target.getMidpoint();
			if (Registry.map.ray(srcPos, dstPos) )
			{
				if (srcPos.x != dstPos.x) 
				{
					_dir = (srcPos.x - dstPos.x) > 0 ? FlxObject.LEFT : FlxObject.RIGHT;
				}					
			}
			
			if (GetChar().isTouching(FlxObject.WALL) && _jumps < 6)
			{
				GetChar().jump(_jumps++>0);
			}
			else if(_jumps >= 6)
			{
				_dir = (_dir == FlxObject.LEFT) ? FlxObject.RIGHT : FlxObject.LEFT;
				_jumps = 0;
			}
			
			
			GetChar().run(_dir);
			
			return _status;
		}
		
	}

}