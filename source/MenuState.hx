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
		maze = new Maze(7, 7);
		guiMaze = new GuiMaze(maze);
		MazeGenerator.generateMaze(maze, beginSearching);
		
		randomizeBtn = new FlxButton(0, 0, "Generate", generateNewMaze);
		add(randomizeBtn);

	}

	function beginSearching()
	{
		guiMaze.updateProblemStats();
		MazeSearcher.search(maze, Strategy.BreadthFirst ,  false);

		//too time consuming
		//MazeSearcher.search(maze, Strategy.DepthFirst ,  false);

		//redundent
		//MazeSearcher.search(maze, Strategy.UniformCost ,  false);
		
		
		MazeSearcher.search(maze, Strategy.Gready(2) ,  false);
		
		//MazeSearcher.search(maze, Strategy.AStar(1) ,  false);

		MazeSearcher.search(maze, Strategy.AStar(2) ,  false);
	}
	
	function generateNewMaze()//generate new Maze 
	{
		if(!maze.isGenerating)
		{
			maze.reset();
			MazeGenerator.generateMaze(maze, beginSearching);
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		guiMaze.update();
	}
}
