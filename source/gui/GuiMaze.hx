package gui; 

import flixel.FlxSprite;

class GuiMaze
{
    private var tileGrid:Array<Array<GuiTile>>;
    private var maze:Maze;
    
    public function new(maze:Maze)
    {

        this.maze = maze;

        tileGrid = new Array<Array<GuiTile>>();
		
        for (i in 0...maze.heightInTiles)
		{
            tileGrid[i] = new Array<GuiTile>();
			for (j in 0...maze.widthInTiles)
			{
				tileGrid[i].push(new GuiTile(0 + Reg.tileSize* j, 0 + Reg.tileSize* i));
			}
		}
    }
    
    public function update()
    {
        for (i in 0...maze.heightInTiles)
		{
			for (j in 0...maze.widthInTiles)
			{
                if(maze.mazeGrid[i][j] == 0)
                    tileGrid[i][j].color = 0xFF00FF00;
			}
		}
    }
}