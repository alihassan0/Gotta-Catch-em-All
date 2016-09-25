package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	var maze:Array<Array<Int>>;

	override public function create():Void
	{
		super.create();
		maze = MazeGenerator.generateMaze(50, 50);
		MazeGenerator.traceMaze(maze);
	}

	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
