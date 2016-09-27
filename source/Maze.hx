package;

class Maze
{
    public var mazeGrid:Array<Array<Int>>;
    public var startLocation:Point;
    public var endLocation:Point;
    public var pokemonLocations:Array<Point>;

    public function new (mazeGrid:Array<Array<Int>>)
    {
        this.mazeGrid = mazeGrid;
    }
}

typedef Point = 
{
    var x:Float;
    var y:Float;
}