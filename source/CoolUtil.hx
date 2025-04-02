package;

import flixel.FlxG;
import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import flixel.util.FlxSave;
#if sys
import sys.io.File;
#end

using StringTools;

class CoolUtil
{
	// [Difficulty name, Chart file suffix]
	public static var difficultyStuff:Array<Dynamic> = [
		['Easy', '-easy'],
		['Normal', ''],
		['Hard', '-hard']
	];

	public static function difficultyString():String
	{
		return difficultyStuff[PlayState.storyDifficulty][0].toUpperCase();
	}

	public static function boundTo(value:Float, min:Float, max:Float):Float {
		var newValue:Float = value;
		if(newValue < min) newValue = min;
		else if(newValue > max) newValue = max;
		return newValue;
	}

	public static function coolTextFile(path:String):Array<String>
	{
		#if sys
		var daList:Array<String> = File.getContent(path).trim().split('\n');
		#else
		var daList:Array<String> = Assets.getText(path).trim().split('\n');
		#end

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	//uhhhh does this even work at all? i'm starting to doubt
	public static function precacheSound(sound:String, ?library:String = null):Void {
		if(!Assets.cache.hasSound(Paths.sound(sound, library))) {
			FlxG.sound.cache(Paths.sound(sound, library));
		}
	}

	public static function browserLoad(site:String) {
		#if linux
		Sys.command('/usr/bin/xdg-open', [site, "&"]);
		#else
		FlxG.openURL(site);
		#end
	}

	/** Quick Function to Fix Save Files for Flixel 5
 		if you are making a mod, you are gonna wanna change "ShadowMario" to something else
 		so Base Psych saves won't conflict with yours
 		@BeastlyGabi
 	**/
 	public static function getSavePath(folder:String = 'KralOyuncu'):String {
 		@:privateAccess
 		return #if (flixel < "5.0.0") folder #else FlxG.stage.application.meta.get('company')
 			+ '/'
 			+ FlxSave.validate(FlxG.stage.application.meta.get('file')) #end;
 	}
 	
 	inline public static function colorFromString(color:String):FlxColor
 	{
 		var hideChars = ~/[\t\n\r]/;
 		var color:String = hideChars.split(color).join('').trim();
 		if(color.startsWith('0x')) color = color.substring(color.length - 6);
 
 		var colorNum:Null<FlxColor> = FlxColor.fromString(color);
 		if(colorNum == null) colorNum = FlxColor.fromString('#$color');
 		return colorNum != null ? colorNum : FlxColor.WHITE;
 	}
 	
 	public static function showPopUp(message:String, title:String):Void
  	{
  		#if android
  		AndroidTools.showAlertDialog(title, message, {name: "OK", func: null}, null);
  		#else
  		FlxG.stage.window.alert(message, title);
  		#end
  	}
}
