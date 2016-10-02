package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import ai.*;
import util.*;
import gui.*;

class MenuState extends FlxState
{
	var maze:Maze;
	var guiMaze:GuiMaze;
	

	//gui
	var randomizeBtn:FlxButton;

	override public function create():Void
	{
		super.create();
		maze = new Maze(9, 9);
		guiMaze = new GuiMaze(maze);
		MazeGenerator.generateMaze(maze, beginSearching);
		
		randomizeBtn = new FlxButton(0, 0, "Generate", generateNewMaze);
		add(randomizeBtn);

	}

	function beginSearching()
	{
		guiMaze.updateProblemStats();
		MazeSearcher.search(maze, Strategy.BreadthFirst ,  false);

		MazeSearcher.search(maze, Strategy.DepthFirst ,  false);
	}
	
	function generateNewMaze()//generate new Maze 
	{
		if(!maze.isGenerating)
		{
			maze.reset();
			MazeGenerator.generateMaze(maze);
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		guiMaze.update();
	}
}
