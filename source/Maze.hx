package;

class Maze
{
    public var mazeGrid:Array<Array<Int>>;
    public var startLocation:Point;
    public var endLocation:Point;
    public var pokemonLocations:Array<Point>;

    public function new ()
    {
    }
}

typedef Point = 
{
    var x:Float;
    var y:Float;
}