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
	
	public class GoalPursueFly extends Goal 
	{
		private var _lastPos:FlxPoint;
		private var _path:FlxPath;
		private var _timer:FlxDelay;
		private var _speed:int = 200;
		static private const _INTERVAL:int = 100;
		
		public function GoalPursueFly(theObj:BaseObj) 
		{
			super(theObj);
			_lastPos = new FlxPoint;
			_timer = new FlxDelay(0);
			_timer.start();
			_speed = FlxMath.vectorLength(GetBaseObj().maxVelocity.x, GetBaseObj().maxVelocity.y) * .5;
			GetBaseObj().drag.make(0, 0);
		}
		
		override public function activate():void 
		{
			_status = ACTIVE;
		}
		
		override public function process():int 
		{
			activateIfInactive()
			if (_status != ACTIVE)  return _status;
			
			if ((_lastPos.x != Registry.player.getMidpoint().x || _lastPos.y != Registry.player.getMidpoint().y) && _timer.hasExpired) 
			{
				_lastPos.copyFrom( Registry.player.getMidpoint());
				
				var srcPos:FlxPoint = GetBaseObj().getMidpoint();
				var dstPos:FlxPoint = Registry.player.getMidpoint();
				if (Registry.map.ray(srcPos, dstPos) )
				{
					FlxVelocity.moveTowardsPoint(GetBaseObj(), dstPos, _speed);
				}
				else
				{
					_path = Registry.map.findPath(srcPos, dstPos, false, false);
					if (_path != null) 
					{
						GetBaseObj().followPath(_path, _speed);
						_timer.reset(_INTERVAL);
					}
					else
					{
						// 重来
						_status = INACTIVE;
					}					
				}			
			}	
			
			return _status;
		}
		
		override public function terminate():void 
		{
			GetBaseObj().stopFollowingPath(true);
		}
		
	}

}