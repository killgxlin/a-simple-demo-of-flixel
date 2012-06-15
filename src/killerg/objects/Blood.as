package killerg.objects 
{
	import org.flixel.*;
	import killerg.objects.*;
	import killerg.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class Blood extends FlxEmitter 
	{
		private var _char:Character = null;
		
		public function Blood() 
		{
			super();
			this.exists = false;
			this.makeParticles(Resource.ImgBlood, 20, 16, false, 1);
			this.gravity = 900;
		}
		
		public function bleed(Char:Character):void 
		{
			this._char = Char;
			this.exists = true;
			this.start(false, 0.1, 0.005, 50);
		}
		
		override public function update():void 
		{
			if (this.on)
			{
				this.at(this._char);
			}
			
			super.update();
						
			if (this.countLiving() == 0) 
			{
				this.exists = false;
			}
		}
	}

}