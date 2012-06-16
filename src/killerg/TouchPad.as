package killerg 
{
	
	import flash.automation.MouseAutomationAction;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class TouchPad extends FlxGroup 
	{
		private var _buttons:FlxGroup;
		private var _fingers:FlxGroup;
		private var _fingerArr:Object = new Object;
		public var jump:Boolean = false;
		public var left:Boolean = false;
		public var right:Boolean = false;
		
		public function TouchPad() 
		{
			super();
			
			if (Capabilities.cpuArchitecture == "ARM") 
			{
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				
				FlxG.stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				FlxG.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
				FlxG.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
				
			}
			else
			{
				FlxG.stage.addEventListener(MouseEvent.MOUSE_DOWN, onTouchBeginDebug);
				FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, onTouchEndDebug);
				FlxG.stage.addEventListener(MouseEvent.MOUSE_MOVE, onTouchMoveDebug);
				FlxG.mouse.show();
				
			}
			
			_buttons = new FlxGroup;
			_fingers = new FlxGroup;
			
			add(_buttons);
			add(_fingers);
			
			addButton(30, 0, function():void 
			{
				left = true;
			}, 20, 20);
			addButton(60, 0, function():void 
			{
				jump = true;
			}, 20, 20);
			addButton(90, 0, function():void 
			{
				right = true;
			}, 20, 20);
		}
		
		override public function update():void 
		{
			left = right = jump = false;
			
			super.update();
			
			FlxG.overlap(_fingers, _buttons, 
				function (Finger:FlxSprite, Btn:Button):void 
				{
					Btn.onTouch();
					
				}, function (Finger:FlxSprite, Button:FlxSprite):Boolean 
				{
					return (FlxCollision.pixelPerfectCheck(Finger, Button));
				}
			)
		}
		
		public function addButton(X:int, Y:int, CallBack:Function = null, Width:int = 20, Heigh:int = 20):void 
		{
			if (CallBack == null) 
			{
				CallBack = function ():void 
				{
					FlxG.flash();
				}
			}
			var button:Button = new Button(CallBack);
			
			button.makeGraphic(Width, Heigh);
			button.scrollFactor.make(0, 0);
			button.cameras = [FlxG.camera];
			button.x = X;
			button.y = Y;			
			
			_buttons.add(button);
		}
	
		public function addFinger(PointID:int, Width:int = 20, Heigh:int = 20):Finger 
		{
			var finger:Finger = new Finger(PointID);
			
			finger.makeGraphic(Width, Heigh, 0xffff0000);			
			finger.scrollFactor.make(0, 0);
			finger.cameras = [FlxG.camera];
			finger.x = 0;
			finger.y = 0;
			
			_fingers.add(finger);
			
			_fingerArr[PointID] = finger;
			
			return finger;
		}
		
		//-------------------------------------------------------------------------------------------------
		private function onTouchBegin(e:TouchEvent):void 
		{
			var finger:Finger = addFinger(e.touchPointID);
			
			finger.syncPos(e.stageX, e.stageY);
		}
		
		private function onTouchMove(e:TouchEvent):void 
		{
			var finger:Finger = _fingerArr[e.touchPointID] as Finger;
			if (finger != null) 
			{
				finger.syncPos(e.stageX, e.stageY);
			}
			
		}
		
		private function onTouchEnd(e:TouchEvent):void 
		{
			var finger:Finger = _fingerArr[e.touchPointID] as Finger;
			if (finger != null) 
			{
				finger.kill();
				_fingerArr[e.touchPointID] = null;
			}
		}
		
		private function onTouchBeginDebug(e:MouseEvent):void 
		{

			var finger:Finger = addFinger(0);
			
			finger.syncPos(e.stageX, e.stageY);
		}
		
		private function onTouchMoveDebug(e:MouseEvent):void 
		{
			var finger:Finger = _fingers.getFirstAlive() as Finger;
			if (finger != null) 
			{
				finger.syncPos(e.stageX, e.stageY);
			}
			
		}
		
		private function onTouchEndDebug(e:MouseEvent):void 
		{
			var finger:Finger = _fingerArr[0] as Finger;
			if (finger != null) 
			{
				finger.kill();
				_fingerArr[0] = null;
			}
		}
		
	
	}

}

import org.flixel.FlxG;
class Button extends org.flixel.FlxSprite
{
	public var onTouch:Function = null;
	public function Button(OnTouch:Function = null)
	{
		super();
		onTouch = OnTouch;
	}
}

class Finger extends org.flixel.FlxSprite
{
	public var touchPointID:int;
	public function Finger(TouchPointID:int)
	{
		super();
		touchPointID = TouchPointID;
	}
	
	override public function draw():void 
	{
		super.draw();
	}
	
	public function syncPos(CurX:int, CurY:int):void 
	{
		x = (CurX - FlxG.camera.x) / FlxG.camera.zoom - width/2;
		y = (CurY - FlxG.camera.y) / FlxG.camera.zoom - height/2;
	}
}