package killerg 
{
	import org.flixel.*;
	import killerg.objects.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class Blood extends FlxEmitter 
	{
		private var char:Character = null;
		
		public function Blood() 
		{
			super();
			this.exists = false;
			this.makeParticles(Resource.ImgBlood, 20, 16, false, 1);
			this.gravity = 900;
		}
		
		public function bleed(char_:Character):void 
		{
			this.char = char_;
			this.exists = true;
			this.start(false, 0.1, 0.005, 50);
		}
		
		override public function update():void 
		{
			if (this.on)
			{
				this.at(this.char);
			}
			
			super.update();
						
			if (this.countLiving() == 0) 
			{
				this.exists = false;
			}
		}
	}

}