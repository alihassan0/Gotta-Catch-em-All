package ai;

import util.*;

class Maze
{
    public var mazeGrid:Array<Array<Int>>;
    public var startLocation:Point;
    public var endLocation:Point;
    public var pokeballLocations:Array<Int>;
    public var moves:Array<Int>;
    public var widthInTiles:Int;
    public var heightInTiles:Int;
    
    public var agentPos:Int = 0;
    public var exitPos:Int = 0;

    public var isGenerating:Bool;


    public function new (widthInTiles:Int, heightInTiles:Int)
    {
        this.widthInTiles = widthInTiles;
        this.heightInTiles = heightInTiles;

        this.mazeGrid = MazeGenerator.createStartingMazeGrid(this);
        this.moves = new Array<Int>();
        
        this.pokeballLocations = new Array<Int>();
    }
    public function toPoint (index:Int):Point
    {
        return {x:Math.floor(index/widthInTiles),y: index%heightInTiles}
    }
}