package killerg.goals.composite 
{
	import killerg.objects.BaseObj;
	import killerg.goals.atomic.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class GoalComposite extends Goal 
	{
		private var _subGoals:Vector.<Goal>;
		
		public function GoalComposite(theObj:BaseObj) 
		{
			super(theObj);
			_subGoals = new Vector.<Goal>;
		}
		
		final public function addSubgoal(goal:Goal):void 
		{
			_subGoals.unshift(goal);
		}
		
		final protected function processSubgoals():void 
		{
			while (_subGoals.length > 0 && (_subGoals[0].isCompleted() || _subGoals[0].hasFailed()))
			{
				_subGoals[0].terminate();
				_subGoals[0] = null;
				_subGoals.shift();
			}
			
			if (_subGoals.length > 0) 
			{
				var statusOfSubgoal:int = _subGoals[0].process();
				if (statusOfSubgoal == COMPLETED && _subGoals.length > 1) 
				{
					return ACTIVE;
				}
				return statusOfSubgoal;
			}
			else
			{
				return COMPLETED;
			}
		}
		
		final public function removeAllSubgoals():void 
		{
			for (var i:int = _subGoals.length-1; i >= 0; i--) 
			{
				_subGoals[i].terminate;
				_subGoals[i] = null;
			}
			
			_subGoals.splice(0, _subGoals.length);
		}
	}

}