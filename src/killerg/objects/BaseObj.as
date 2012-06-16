package killerg.objects 
{
	import org.flixel.*;
	import killerg.objects.*;
	import killerg.goals.atomic.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class BaseObj extends FlxSprite 
	{
		static public const ZEROVECTOR:FlxPoint = new FlxPoint(0, 0);
		static public const INVALID:int = -1;
		
		private var _action:Goal = null;
		private var _effects:Vector.<Goal> = null;
		
		final public function setAction(Ctrllor:Goal):void 
		{
			this._action = Ctrllor;
		}
			
		final private function FindEffect(Effect:Goal):int 
		{
			var len:int = _effects.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (_effects[i] == Effect) 
				{
					return i;
				}
			}
			
			return INVALID;
		}
		
		final private function updateEffects():void 
		{
			var len:int = _effects.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if (_effects[i] != null) 
				{
					_effects[i].process();
					if (_effects[i].hasFailed() || _effects[i].isCompleted()) 
					{
						_effects[i].terminate();
						_effects[i] = null;
					}
				}
			}
		}
		
		final private function endAllEffect():void 
		{
			var len:int = _effects.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (_effects[i] != null) 
				{
					_effects[i].terminate();
					_effects[i] = null;					
				}
			}
		}
		
		public function BaseObj(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			_effects = new Vector.<Goal>(10);
		}
		
		override public function destroy():void 
		{
			super.destroy();
			_action = null;
			_effects = null;
		}
		
		override public function kill():void 
		{
			super.kill();
			endAllEffect();
			
			if (_action != null) 
			{
				_action.terminate();
				_action = null;
			}
		}
		
		override public function update():void 
		{
			if (_action != null) 
			{
				_action.process();
				if (_action.hasFailed() || _action.isCompleted()) 
				{
					_action.terminate();
					_action = null;
				}
			}
			
			updateEffects();		
			super.update();
		}
		
		final public function addEffect(Effect:Goal):void 
		{
			if (Effect == null) return;
			
			var idx:int = FindEffect(Effect);
			if (idx != INVALID) return;
			
			idx = FindEffect(null);
			if (idx == INVALID) return;
			
			_effects[idx] = Effect;
		}
		
		final public function removeEffect(Effect:Goal):void 
		{
			if (Effect == null) return;
			
			var idx:int = FindEffect(Effect);
			if (idx == INVALID) return;
			
			Effect.terminate();
			_effects[idx] = null;
		}
		
	}
}