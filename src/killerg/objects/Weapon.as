package killerg.objects 
{
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author killerg
	 */
	public interface Weapon 
	{
		function launch(Parent:Character, Args:Object = null):Boolean;
		function hitMap(Map:FlxTilemap):void ;
		function hitChar(Parent:Character):void ;
	}
	
}