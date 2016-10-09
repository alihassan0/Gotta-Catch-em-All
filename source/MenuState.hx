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
		
		var availableStrategies:Array<Strategy> = [Strategy.BreadthFirst, Strategy.DepthFirst, Strategy.AStar(1)
													,Strategy.AStar(2), Strategy.AStar(3)];
		var guiSearchPanel;
		for (i in 0...availableStrategies.length)
		{
			guiSearchPanel = new GuiSearchPanel(FlxG.width - 150, 100*i, availableStrategies[i], guiMaze);
		}
		 

		randomizeBtn = new FlxButton(0, 0, "Generate", generateNewMaze);
		add(randomizeBtn);

	}

	function beginSearching()
	{
		guiMaze.updateProblemStats();
		trace("#############################################");


		

		


		// //too time consuming
		// MazeSearcher.search(maze, Strategy.DepthFirst ,  false);

		// //redundent
		// //MazeSearcher.search(maze, Strategy.UniformCost ,  false);
		
		
		//  MazeSearcher.search(maze, Strategy.Gready(1) ,  false);
		 
		//  MazeSearcher.search(maze, Strategy.Gready(2) ,  false);
		 
		// //  MazeSearcher.search(maze, Strategy.Gready(3) ,  false);
		
		//  MazeSearcher.search(maze, Strategy.AStar(1) ,  false);

		//  MazeSearcher.search(maze, Strategy.AStar(2) ,  false);

		//  MazeSearcher.search(maze, Strategy.AStar(3) ,  false);
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
