package ai;

import util.*;
import ai.base.*;

class Maze extends Problem<MazeState>
{
    public var mazeGrid:Array<Array<Int>>;
    public var moves:Array<Int>;
    public var widthInTiles:Int;
    public var heightInTiles:Int;
    
    public var pokemonsLocations:Array<Int>;
    public var initialHatchingDistance:Int;
    public var agentPos:Int = 0;
    public var agentDirection:Direction = Direction.South;
    
    public var exitPos:Int = 0;

    public var isGenerating:Bool;
    public var isSearching:Bool;

    public function new (widthInTiles:Int, heightInTiles:Int)
    {
        super();
        this.widthInTiles = widthInTiles;
        this.heightInTiles = heightInTiles;

        this.mazeGrid = MazeGenerator.createStartingMazeGrid(this);
        this.moves = new Array<Int>();
        
        this.pokemonsLocations = new Array<Int>();
        this.operators = [Operator.MoveForward, Operator.RotateLeft, Operator.RotateRight];
        addHeuristicFunctions();
        
    }

    private function addHeuristicFunctions ()
    {
        heuristicFunctions.push(manhatenHeuristics);
        heuristicFunctions.push(clusteringHeuristics);
        heuristicFunctions.push(extendedManhatenHeuristics);
    }

    
    //get nearest goal
    private function extendedManhatenHeuristics(state:MazeState):Int
    {

        var sumheuristics = 0;

         //clone pokemonLocations array 
        var pokemonLocations:Array<Int> = [for (i in 0...state.getPokemonsLocations().length) state.getPokemonsLocations()[i]];    
        var lastNode = state.getPosition(); 

        while(!(pokemonLocations.length<1))
        {
            var minIndex = indexOfClosestPokemon(pokemonsLocations, lastNode);
            sumheuristics += getDistanceFrom(lastNode,toPoint(minIndex));
            pokemonLocations.splice(minIndex,1);
        }
        return sumheuristics;
    }    

    private function indexOfClosestPokemon(pokemonsLocations: Array<Int>, referencePoint:Point): Int
    {
        
        if (pokemonsLocations.length == 0) {
            return -1;
        }

        var min = pokemonsLocations[0];
        var minIndex = 0;

        for (i in 0...pokemonsLocations.length)
        {

            // we are storing distances instead of pokemons indecies in the same array to save memory 
            var distance = getDistanceFrom(toPoint(pokemonsLocations[i]),referencePoint);
            if (pokemonsLocations[i] < min) {
                minIndex = i;
                min = pokemonsLocations[i];
            }

        }

        return minIndex;
    }

    //get nearest goal
    private function manhatenHeuristics(state:MazeState):Int
    {
        var minDistance = 0;
        //suggestion : take direction into account
        if(state.getPokemonsLocations().length > 0) //not all pokemons are acquired
            minDistance = state.getDistanceFrom(toPoint(state.getPokemonsLocations()[0]));
        else // if he acquired all pokemons .. return min distance to goal
            return state.getDistanceFrom(toPoint(exitPos));

        for (i in 1...state.getPokemonsLocations().length)
        {
            var distance = state.getDistanceFrom(toPoint(state.getPokemonsLocations()[i]));
            if(distance < minDistance)
                minDistance = distance;
        }
        return minDistance;
    }
    private function clusteringHeuristics(state:MazeState):Int
    {
        //take direction into account
        if(state.getPokemonsLocations().length < 1) //not all pokemons are acquired
            return state.getDistanceFrom(toPoint(exitPos));

        var distancesArray = [for (i in 0...state.getPokemonsLocations().length) 0];
        
        for (i in 0...state.getPokemonsLocations().length)
        {
            for (j in 0...state.getPokemonsLocations().length)
            {
                if(i != j)
                {
                    distancesArray[i] += getDistanceFrom(toPoint(state.getPokemonsLocations()[i])
                                                        ,toPoint(state.getPokemonsLocations()[j]));
                }
            }
        }
        return state.getDistanceFrom(toPoint(state.getPokemonsLocations()[indexOfMin(distancesArray)]));
        
    }
    
    function indexOfMin(array:Array<Int>) {
        if (array.length == 0) {
            return -1;
        }

        var min = array[0];
        var minIndex = 0;

        for (i in 0...array.length) {
            if (array[i] < min) {
                minIndex = i;
                min = array[i];
            }
        }
        return minIndex;
    }

    public function getDistanceFrom(point1:Point, point2:Point)
	{
		return Math.floor(Math.abs(point1.x - point2.x) + 
							Math.abs(point1.y - point2.y));
	}

    override public function setInitialState ()
    {
        var allPokemonLocations:Array<Int> = [for (i in 0...pokemonsLocations.length) pokemonsLocations[i]];    
        this.initialState = new MazeState({x:toPoint(agentPos).x, y:toPoint(agentPos).y}, Direction.South,
                                            allPokemonLocations, initialHatchingDistance);
        
    }
    override public function isValidState (state:MazeState) : Bool  
    {
        return mazeGrid[state.getPosition().x][state.getPosition().y] != 1;
    }
    override public function goalTest (state:MazeState): Bool
    {
        var point = toPoint(exitPos);
        if(state.getPosition().x == point.x && state.getPosition().y == point.y 
        && state.getPokemonsLocations().length == 0)
        {
           return true ;
        }
        return false ;
    }
    override public function apply (state:MazeState, operator:Operator): MazeState
    {
        //clone pokemonLocations array 
        var pokemonLocations:Array<Int> = [for (i in 0...state.getPokemonsLocations().length) state.getPokemonsLocations()[i]];    
     
        //clone parent state into a new identical state 
        var newState:MazeState = new MazeState({x:state.getPosition().x, y:state.getPosition().y}, state.getDirection(), 
                                                pokemonLocations, state.getHatchingDistanceLeft());

        //modify new state depending on operator
        switch(operator)
        {
            case Operator.MoveForward:
                
                //update position 
                switch(state.getDirection())
                {
                    case Direction.North:
                        newState.getPosition().x --;

                    case Direction.East:
                        newState.getPosition().y ++;

                    case Direction.South:
                        newState.getPosition().x ++;
                    
                    case Direction.West:
                        newState.getPosition().y --;

                }
                //if the new state contains pokemon remove it from it's array; 
                newState.getPokemonsLocations().remove(toIndex(newState.getPosition().x,newState.getPosition().y));

                //decrement time to left to hatch the egg
                newState.decrementHatchingDistanceLeft();

            case Operator.RotateLeft:
                //change direction
                newState.setDirection(Type.createEnumIndex(Direction, (Type.enumIndex(state.getDirection())-1+4)%4));
            case Operator.RotateRight:
                //change direction
                newState.setDirection(Type.createEnumIndex(Direction, (Type.enumIndex(state.getDirection())+1+4)%4));
        }
        return newState;
    }
    public function reset ()
    {
        this.moves = new Array<Int>();
        this.pokemonsLocations = new Array<Int>();
    }
    public function toPoint (index:Int):Point
    {
        return {x: index%heightInTiles, y:Math.floor(index/widthInTiles)}
    }
    public function toIndex (x:Int, y:Int):Int
    {
        return y * widthInTiles + x;
    }
}