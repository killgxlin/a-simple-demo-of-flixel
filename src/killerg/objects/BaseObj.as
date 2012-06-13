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
		
		private var action:Goal = null;
		private var effects:Vector.<Goal> = null;
		
		final public function setAction(ctrllor:Goal):void 
		{
			this.action = ctrllor;
		}
			
		final private function FindEffect(effect:Goal):int 
		{
			var len:int = effects.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (effects[i] == effect) 
				{
					return i;
				}
			}
			
			return INVALID;
		}
		
		final private function updateEffects():void 
		{
			var len:int = effects.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if (effects[i] != null) 
				{
					effects[i].process();
					if (effects[i].hasFailed() || effects[i].isCompleted()) 
					{
						effects[i].terminate();
						effects[i] = null;
					}
				}
			}
		}
		
		final private function endAllEffect():void 
		{
			var len:int = effects.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (effects[i] != null) 
				{
					effects[i].terminate();
					effects[i] = null;					
				}
			}
		}
		
		public function BaseObj(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			effects = new Vector.<Goal>(10);
		}
		
		override public function destroy():void 
		{
			super.destroy();
			action = null;
			effects = null;
		}
		
		override public function kill():void 
		{
			super.kill();
			endAllEffect();
			
			if (action != null) 
			{
				action.terminate();
				action = null;
			}
		}
		
		override public function update():void 
		{
			if (action != null) 
			{
				action.process();
				if (action.hasFailed() || action.isCompleted()) 
				{
					action.terminate();
					action = null;
				}
			}
			
			updateEffects();		
			super.update();
		}
		
		final public function addEffect(effect:Goal):void 
		{
			if (effect == null) return;
			
			var idx:int = FindEffect(effect);
			if (idx != INVALID) return;
			
			idx = FindEffect(null);
			if (idx == INVALID) return;
			
			effects[idx] = effect;
		}
		
		final public function removeEffect(effect:Goal):void 
		{
			if (effect == null) return;
			
			var idx:int = FindEffect(effect);
			if (idx == INVALID) return;
			
			effect.terminate();
			effects[idx] = null;
		}
		
	}

}