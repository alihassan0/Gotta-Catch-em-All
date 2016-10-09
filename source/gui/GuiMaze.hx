package gui; 

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import ai.Maze;
import util.*;  

class GuiMaze
{
    private var tileGrid:Array<Array<GuiTile>>;
    
    public var maze:Maze;

    public var guiAgent:GuiAgent;

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
				tileGrid[i].push(new GuiTile(Reg.mapOffset.x + Reg.tileSize* j, Reg.mapOffset.y + Reg.tileSize* i));
			}
		}

        mazeStats = new FlxText(FlxG.width - 200, 0, 200, "stats", 16);
        FlxG.state.add(mazeStats);

        guiAgent = new GuiAgent(0,0, this);
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

        for (i in 0...maze.pokemonsLocations.length){
            var pos = maze.toPoint(maze.pokemonsLocations[i]);
            tileGrid[pos.x][pos.y].animation.frameIndex = 63 ;
        }

        var pos = maze.toPoint(maze.exitPos);
        tileGrid[pos.x][pos.y].animation.frameIndex = 57;
        pos = maze.toPoint(maze.agentPos);
        guiAgent.moveTo(pos.x, pos.y);
        guiAgent.setDirection(maze.agentDirection);
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
            
            if(maze.moves.length > 0){//show digger
                var lastMove:Point = maze.toPoint(maze.moves[maze.moves.length -1]);
                guiAgent.moveTo(lastMove.y, lastMove.x);
            }
        }
    }
    public function collectPokemon(x:Int, y:Int)
    {
        var index = maze.pokemonsLocations.indexOf(maze.toIndex(x,y));
        if(index != -1)
        {
            var pos = maze.toPoint(maze.pokemonsLocations[index]);
            tileGrid[pos.x][pos.y].animation.frameIndex = 52 ;
        }
    }
    
}