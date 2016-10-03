package gui; 

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import ai.Maze;

class GuiMaze
{
    private var tileGrid:Array<Array<GuiTile>>;
    private var maze:Maze;

    private var mazeStats:FlxText;
    
    public function new(maze:Maze)
    {

        this.maze = maze;
        tileGrid = new Array<Array<GuiTile>>();
		
        for (i in 0...maze.heightInTiles)
		{
            tileGrid[i] = new Array<GuiTile>();
			for (j in 0...maze.widthInTiles)
			{
				tileGrid[i].push(new GuiTile(0 + Reg.tileSize* j, 30 + Reg.tileSize* i));
			}
		}

        mazeStats = new FlxText(FlxG.width - 200, 0, 200, "stats", 16);
        FlxG.state.add(mazeStats);
    }
    
    public function updateProblemStats():Void
    {
        mazeStats.text = "Maze Stats: \n";
        mazeStats.text += "w :"+ maze.widthInTiles+ ", h :" + maze.heightInTiles +"\n";
        
        //x,y  switched to make it easier for the viewer 
        var pos = maze.toPoint(maze.agentPos);
        mazeStats.text += "agent => x :"+ pos.y + ", y :" + pos.x +"\n";
        pos = maze.toPoint(maze.exitPos);
        mazeStats.text += "door => x :"+ pos.y + ", y :" + pos.x +"\n";
        
        mazeStats.text += "pokemons => "+ maze.pokemonsLocations.length +"\n";
        mazeStats.text += "hatch dst => "+ maze.initialHatchingDistance +"\n";
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
                    else
                        tileGrid[i][j].animation.frameIndex = 32;

                }
            }
            if(maze.moves.length != 0){//show digger
                var lastMove:Int = maze.moves[maze.moves.length -1];
                tileGrid[Math.floor(lastMove/maze.widthInTiles)][lastMove%maze.heightInTiles].animation.frameIndex = 0  ;
            }
        }
        else
        {
            for (i in 0...maze.pokemonsLocations.length){
                var pos = maze.toPoint(maze.pokemonsLocations[i]);
                tileGrid[pos.x][pos.y].animation.frameIndex = 63  ;
            }
            var pos = maze.toPoint(maze.exitPos);
            tileGrid[pos.x][pos.y].animation.frameIndex = 57;
            pos = maze.toPoint(maze.agentPos);
            tileGrid[pos.x][pos.y].animation.frameIndex = 1;
        }
    }
}