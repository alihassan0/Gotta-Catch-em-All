package;


class MazeGenerator
{
	public static function generateMaze(mazeWidth:Int, mazeHeight:Int):Maze
	{
        var mazeGrid:Array<Array<Int>> = new Array<Array<Int>>();
		var moves:Array<Int> = new Array<Int>();

        for (i in 0...mazeHeight)
		{
            mazeGrid[i] = new Array<Int>();
			for (j in 0...mazeWidth)
			{
				mazeGrid[i][j] = 1;
			}
		}

        var posX:Int = 1;
        var posY:Int = 1;
        
		mazeGrid[posX][posY] = 0; 
        
		moves.push(posY + posY * mazeWidth);

		while(moves.length != 0){       
			var possibleDirections = "";
			
			if(inBounds(posX+2, mazeHeight) && isOccupiedTile(posX + 2,posY, mazeGrid))
					possibleDirections += "S";
			if(inBounds(posX-2, mazeHeight) && isOccupiedTile(posX - 2,posY, mazeGrid))
					possibleDirections += "N";

			if(inBounds(posY-2, mazeWidth) && isOccupiedTile(posX,posY - 2, mazeGrid))
					possibleDirections += "W";
			if(inBounds(posY+2, mazeWidth) && isOccupiedTile(posX,posY + 2, mazeGrid))
					possibleDirections += "E";
			if(possibleDirections != ""){
					var move:String = possibleDirections.charAt(Math.floor(Math.random()*possibleDirections.length));

					switch (move){
						case "N": 
							mazeGrid[posX - 2][posY] = 0;
							mazeGrid[posX - 1][posY] = 0;
							posX -= 2;
						case "S":
							mazeGrid[posX + 2][posY] = 0;
							mazeGrid[posX + 1][posY] = 0;
							posX += 2;
						case "W":
							mazeGrid[posX][posY - 2] = 0;
							mazeGrid[posX][posY - 1] = 0;
							posY -= 2;
						case "E":
							mazeGrid[posX][posY + 2]=0;
							mazeGrid[posX][posY + 1]=0;
							posY += 2;
					}
					moves.push(posY + posX * mazeWidth);     
			}
			else{
					var back = moves.pop();
					posX = Math.floor(back / mazeWidth);
					posY = back % mazeWidth;
			}                                
		}
		var maze:Maze = new Maze();
		maze.mazeGrid = mazeGrid;
		return maze;

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
