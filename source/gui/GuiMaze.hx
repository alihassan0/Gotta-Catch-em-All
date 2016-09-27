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
        if(maze.isGenerating)
        {
            //TODO strict update on maze.isGenerating
            for (i in 0...maze.heightInTiles)
            {
                for (j in 0...maze.widthInTiles)
                {
                    if(maze.mazeGrid[i][j] == 0)
                        tileGrid[i][j].animation.frameIndex = 52;
                }
            }
            if(maze.moves.length != 0){
                var lastMove:Int = maze.moves[maze.moves.length -1];
                tileGrid[Math.floor(lastMove/maze.widthInTiles)][lastMove%maze.heightInTiles].animation.frameIndex = 0  ;
            }
        }
        else
        {
            for (i in 0...maze.pokeballLocations.length){
                var pos = maze.toPoint(maze.pokeballLocations[i]);
                tileGrid[pos.x][pos.y].animation.frameIndex = 63  ;
            }
            var pos = maze.toPoint(maze.exitPos);
            tileGrid[pos.x][pos.y].animation.frameIndex = 57;
            pos = maze.toPoint(maze.agentPos);
            tileGrid[pos.x][pos.y].animation.frameIndex = 1;
        }
    }
}