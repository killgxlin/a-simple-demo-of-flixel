package killerg.goals.atomic
{
	import org.flixel.*;
	import killerg.objects.*;
	import killerg.managers.*;
	/**
	 * ...
	 * @author killerg
	 */
	public class Goal 
	{
		static public const INACTIVE:int	= 0;
		static public const ACTIVE:int		= 1;
		static public const COMPLETED:int	= 2;
		static public const FAILED:int		= 3;		
				
		protected var _status:int;
		
		private var _theObj:BaseObj;
		
		final protected function GetChar():Character
		{
			return _theObj as Character;
		}
		final protected function GetWeapon():Arrow 
		{
			return _theObj as Arrow;
		}
		final protected function GetBaseObj():BaseObj 
		{
			return _theObj;
		}
		public function Goal(theObj:BaseObj)
		{
			_theObj = theObj;
			_status = INACTIVE;
		}

		final public function activateIfInactive():void 
		{
			if (_status == INACTIVE) 
			{
				activate();
			}
		}
		
		public function activate():void {}
		
		public function process():int { return FAILED; }
		
		public function terminate():void { }
		
		public function isCompleted():Boolean
		{
			return _status == COMPLETED;
		}
		
		public function hasFailed():Boolean 
		{
			return _status == FAILED;
		}
	}
	
}