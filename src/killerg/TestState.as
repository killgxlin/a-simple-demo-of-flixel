package killerg 
{
	import adobe.utils.ProductManager;
	import flash.accessibility.AccessibilityImplementation;
	import org.flixel.*;
	

	/**
	 * ...
	 * @author killerg
	 */
	public class TestState extends FlxState 
	{
		public var _num:int = 0;
		public var arr:Array = new Array;
		public var f:Function;
		public var obj:Object = new Object;
		public function TestState() 
		{
			
		}
		override public function create():void 
		{
			super.create();
			var obj1:Object = new Object;
			obj1.haha = "hello"
			obj1.f = function():void 
			{
				add(new FlxText(20, 20, 40, haha));
			}
			
		}
		override public function update():void 
		{
			super.update();
				obj.f();
		}
	}


}
