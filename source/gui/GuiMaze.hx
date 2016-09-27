package gui; 

import flixel.FlxSprite;

class GuiMaze
{
    private var tileGrid:Array<Array<GuiTile>>;

    private var widthInTiles:Int;
    private var heightInTiles:Int;
    private var maze:Maze;
    
    public function new(widthInTiles:Int, heightInTiles:Int, maze:Maze)
    {
        this.widthInTiles = widthInTiles;
        this.heightInTiles = heightInTiles;
        this.maze = maze;

        tileGrid = new Array<Array<GuiTile>>();
		
        for (i in 0...heightInTiles)
		{
            tileGrid[i] = new Array<GuiTile>();
			for (j in 0...widthInTiles)
			{
				tileGrid[i].push(new GuiTile(0 + Reg.tileSize* j, 0 + Reg.tileSize* i));
                trace(i, tileGrid[i].length);
			}
		}
        trace(tileGrid[1][1]);
    }
    
    public function update()
    {
        for (i in 0...heightInTiles)
		{
			for (j in 0...widthInTiles)
			{
                if(maze.mazeGrid[i][j] == 0)
                    tileGrid[i][j].color = 0xFF00FF00;
			}
		}
    }
}