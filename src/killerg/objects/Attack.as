package killerg.objects 
{
	/**
	 * ...
	 * @author killerg
	 */
	public class Attack extends BaseObj 
	{
		protected var _owner:BaseObj = null;
		
		public function Attack(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
		}
		
		override public function update():void 
		{
			
		}
		
		override public function destroy():void 
		{
			
		}
		
		public function launch():void 
		{
			
		}
		
	}

}