package killerg.managers
{
	import org.flixel.*;
	import killerg.objects.*;
	import killerg.*;
	
	/**
	 * ...
	 * @author killerg
	 */
	public class ArrowMgr extends FlxGroup 
	{
		
		public function ArrowMgr() 
		{
			for (var i:int = 0; i < Resource.ARROW_NUM; ++i)
			{
				add(new Arrow);
			}
		}
		
		public function fire(char:Character, idx:int):void 
		{
			var arrow:Arrow = getFirstAvailable() as Arrow;
			if (arrow != null) 
			{
				arrow.fire(char,idx);
			}
		}
				
		public function hitChar(arrow:Arrow,char:Character):void 
		{
			// 箭扎到敌人
			if (arrow.owner != char && arrow.moves == true) 
			{
				arrow.stop();
				char.hurt(1);			
				arrow.kill();	
			}
			
			// 主人捡到箭
			if (arrow.owner == char && arrow.moves == false) 
			{
				arrow.kill();
			}
		}

		public function hitMap(arrow:Arrow,map:FlxTilemap):void 
		{
			arrow.stop();
		}
		
	}

}