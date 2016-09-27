package;

class Maze
{
    public var mazeGrid:Array<Array<Int>>;
    public var startLocation:Point;
    public var endLocation:Point;
    public var pokemonLocations:Array<Point>;
    public var moves:Array<Int>;
    public var widthInTiles:Int;
    public var heightInTiles:Int;

    public function new (widthInTiles:Int, heightInTiles:Int)
    {
        this.widthInTiles = widthInTiles;
        this.heightInTiles = heightInTiles;

        this.mazeGrid = MazeGenerator.createStartingMazeGrid(this);
        this.moves = new Array<Int>();


    }
}

typedef Point = 
{
    var x:Float;
    var y:Float;
}