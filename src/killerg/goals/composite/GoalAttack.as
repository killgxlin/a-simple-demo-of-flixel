package killerg.goals.composite 
{
	import killerg.managers.CharacterMgr;
	import killerg.objects.BaseObj;
	import killerg.objects.Character;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class GoalAttack extends GoalComposite 
	{
		private var _target:Character;
		
		public function GoalAttack(theObj:BaseObj, target:Character) 
		{
			super(theObj);
			_target = target;			
		}
		override public function activate():void 
		{
			
		}
		
		override public function process():int 
		{
			
		}
		
		override public function terminate():void 
		{
			
		}
	}

}