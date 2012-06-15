package killerg 
{
	/**
	 * ...
	 * @author killerg
	 */
	public class Resource 
	{
		static public const ARROW_NUM:int = 20;
		static public const SLASH_NUM:int = 4;
		static public const CHARACTER_NUM:int = 20;
		static public const BLOOD_NUM:int = 20;
		static public const ARROW_LIVE:int = 500;
		
		
		[Embed(source = "../data/character.png")]	static public var ImgChar:Class;
		[Embed(source = "../data/tiles.png")]		static public var ImgTiles:Class;
		[Embed(source = "../data/arrow.png")]		static public var ImgArrow:Class;
		[Embed(source = "../data/slash.png")]		static public var ImgSlash:Class;
		[Embed(source = "../data/blood.png")]		static public var ImgBlood:Class;
		
		[Embed(source = "../data/mapCSV_Group1_Tiles.csv", mimeType = "application/octet-stream")]		static public var CsvTilesData:Class;
		[Embed(source = "../data/mapCSV_Group1_Flat.csv", mimeType = "application/octet-stream")]		static public var CsvFlatData:Class;
		
	}

}