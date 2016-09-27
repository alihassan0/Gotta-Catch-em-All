package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import gui.GuiMaze;

class MenuState extends FlxState
{
	var maze:Maze;
	var guiMaze:GuiMaze;

	override public function create():Void
	{
		super.create();
		maze = new Maze(39, 39);
		guiMaze = new GuiMaze(maze);
		MazeGenerator.generateMaze(maze);
		
		// MazeGenerator.traceMaze(maze);

		
	}

	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		guiMaze.update();
	}
}
