package ai;

import util.*;

class MazeGenerator
{
 	public static function generateMaze(maze:Maze, ?onCompleted:Void->Void):Maze
	{
		var mazeGrid:Array<Array<Int>> = maze.mazeGrid;

        for (i in 0...maze.heightInTiles)
		{
            mazeGrid[i] = new Array<Int>();
			for (j in 0...maze.widthInTiles)
			{
				mazeGrid[i][j] = 1;
			}
		}

        var posX:Int = 1;
        var posY:Int = 1;
        
		mazeGrid[posX][posY] = 0; 
        
		maze.moves.push(posY + posX * maze.widthInTiles);
		maze.isGenerating = true;

		haxe.Timer.delay(MazeGenerator.move.bind(maze, posX, posY, onCompleted), Reg.delay); // 1s                              

		return maze;
	}
    public static function move(maze:Maze,  posX:Int , posY:Int, ?onCompleted:Void->Void):Void
	{
		if(maze.moves.length != 0){       
			var possibleDirections = "";
			
			if(inBounds(posX+2, maze.heightInTiles) && isOccupiedTile(posX + 2,posY, maze.mazeGrid))
					possibleDirections += "S";
			if(inBounds(posX-2, maze.heightInTiles) && isOccupiedTile(posX - 2,posY, maze.mazeGrid))
					possibleDirections += "N";

			if(inBounds(posY-2, maze.widthInTiles) && isOccupiedTile(posX,posY - 2, maze.mazeGrid))
					possibleDirections += "W";
			if(inBounds(posY+2, maze.widthInTiles) && isOccupiedTile(posX,posY + 2, maze.mazeGrid))
					possibleDirections += "E";
			if(possibleDirections != ""){
					var move:String = possibleDirections.charAt(Math.floor(Math.random()*possibleDirections.length));

					switch (move){
						case "N": 
							maze.mazeGrid[posX - 2][posY] = 0;
							maze.mazeGrid[posX - 1][posY] = 0;
							posX -= 2;
						case "S":
							maze.mazeGrid[posX + 2][posY] = 0;
							maze.mazeGrid[posX + 1][posY] = 0;
							posX += 2;
						case "W":
							maze.mazeGrid[posX][posY - 2] = 0;
							maze.mazeGrid[posX][posY - 1] = 0;
							posY -= 2;
						case "E":
							maze.mazeGrid[posX][posY + 2]=0;
							maze.mazeGrid[posX][posY + 1]=0;
							posY += 2;
					}
					maze.moves.push(posY + posX * maze.widthInTiles);     
			}
			else{
					var back = maze.moves.pop();
					posX = Math.floor(back / maze.widthInTiles);
					posY = back % maze.widthInTiles;
			}
			haxe.Timer.delay(MazeGenerator.move.bind(maze, posX, posY, onCompleted), Reg.delay); // 1s                              
		}
		else
		{
			maze.isGenerating = false;
			//TODO change random function
			var randomBallCount:Int = 2;//5 + Math.floor(Math.random()*5);
			var availableTiles:Array<Int> = new Array<Int>();
			
			for (i in 0...maze.heightInTiles)
				for (j in 0...maze.widthInTiles)
					if(maze.mazeGrid[i][j] == 0){
						availableTiles.push(i + j * maze.widthInTiles);
					}
			
			for (i in 0...randomBallCount)
			{
				Random.shuffle(availableTiles);
				maze.pokemonsLocations.push(availableTiles.shift());
			}
			Random.shuffle(availableTiles);
			maze.agentPos = availableTiles.shift();	
			Random.shuffle(availableTiles);
			maze.exitPos = availableTiles.shift();
			maze.initialHatchingDistance = Random.int(4,50);
			maze.setInitialState ();

			if(onCompleted != null)
				onCompleted();
		}
	}
    public static function createStartingMazeGrid(maze:Maze):Array<Array<Int>>
	{
		var mazeGrid:Array<Array<Int>> = new Array<Array<Int>>();

        for (i in 0...maze.heightInTiles)
		{
            mazeGrid[i] = new Array<Int>();
			for (j in 0...maze.widthInTiles)
			{
				mazeGrid[i][j] = 1;
			}
		}

		return mazeGrid;
	}
    public static function traceMaze(maze:Maze):Void
	{
		var s:String = "\n";
		for (i in 0...maze.mazeGrid.length)
		{
			for (j in 0...maze.mazeGrid[i].length)
			{
				s += (maze.mazeGrid[i][j] == 1)?"x": ".";
			}
			s += "\n";
		}
		trace(s);
	}
	public static function inBounds(n:Int, max:Int):Bool
	{
		return n > 0 && n < max - 1;
	}
	public static function isOccupiedTile(x:Int, y:Int, mazeGrid:Array<Array<Int>>):Bool
	{
		return mazeGrid[x][y] == 1;
	}
}
