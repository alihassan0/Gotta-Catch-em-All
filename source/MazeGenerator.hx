package;


class MazeGenerator
{
	public static function generateMaze(mazeWidth:Int, mazeHeight:Int):Array<Array<Int>>
	{
        var maze:Array<Array<Int>> = new Array<Array<Int>>();
		var moves:Array<Int> = new Array<Int>();

        for (i in 0...mazeHeight)
		{
            maze[i] = new Array<Int>();
			for (j in 0...mazeWidth)
			{
				maze[i][j] = 1;
			}
		}

        var posX:Int = 1;
        var posY:Int = 1;
        
		maze[posX][posY] = 0; 
        
		moves.push(posY + posY * mazeWidth);

		while(moves.length != 0){       
			var possibleDirections = "";
			
			if(inBounds(posX+2, mazeHeight) && isOccupiedTile(posX + 2,posY, maze))
					possibleDirections += "S";
			if(inBounds(posX-2, mazeHeight) && isOccupiedTile(posX - 2,posY, maze))
					possibleDirections += "N";

			if(inBounds(posY-2, mazeWidth) && isOccupiedTile(posX,posY - 2, maze))
					possibleDirections += "W";
			if(inBounds(posY+2, mazeWidth) && isOccupiedTile(posX,posY + 2, maze))
					possibleDirections += "E";
			if(possibleDirections != ""){
					var move:String = possibleDirections.charAt(Math.floor(Math.random()*possibleDirections.length));

					switch (move){
						case "N": 
							maze[posX - 2][posY] = 0;
							maze[posX - 1][posY] = 0;
							posX -= 2;
						case "S":
							maze[posX + 2][posY] = 0;
							maze[posX + 1][posY] = 0;
							posX += 2;
						case "W":
							maze[posX][posY - 2] = 0;
							maze[posX][posY - 1] = 0;
							posY -= 2;
						case "E":
							maze[posX][posY + 2]=0;
							maze[posX][posY + 1]=0;
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
        return maze;
	}
    public static function traceMaze(maze:Array<Array<Int>>):Void
	{
		var s:String = "\n";
		for (i in 0...maze.length)
		{
			for (j in 0...maze[i].length)
			{
				s += (maze[i][j] == 1)?"x": ".";
			}
			s += "\n";
		}
		trace(s);
	}
	public static function inBounds(n:Int, max:Int):Bool
	{
		return n > 0 && n < max - 1;
	}
	public static function isOccupiedTile(x:Int, y:Int, maze:Array<Array<Int>>):Bool
	{
		return maze[x][y] == 1;
	}
}
