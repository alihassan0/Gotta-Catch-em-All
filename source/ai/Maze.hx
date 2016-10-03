package ai;

import util.*;
import ai.base.*;

class Maze extends Problem<MazeState>
{
    public var mazeGrid:Array<Array<Int>>;
    public var pokemonsLocations:Array<Int>;
    public var moves:Array<Int>;
    public var widthInTiles:Int;
    public var heightInTiles:Int;
    public var initialHatchingDistance:Int;
    
    public var agentPos:Int = 0;
    public var exitPos:Int = 0;

    public var isGenerating:Bool;

    public function new (widthInTiles:Int, heightInTiles:Int)
    {
        super();
        this.widthInTiles = widthInTiles;
        this.heightInTiles = heightInTiles;

        this.mazeGrid = MazeGenerator.createStartingMazeGrid(this);
        this.moves = new Array<Int>();
        
        this.pokemonsLocations = new Array<Int>();
        this.operators = [Operator.MoveForward, Operator.RotateLeft, Operator.RotateRight];
        
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
        if(state.getPosition().x == point.x && state.getPosition().y == point.y && state.getPokemonsLocations.length == 0 && state.getHatchingDistanceLeft() <= 0)
        {
           return true ;
        }
        return false ;
    }
    override public function apply (state:MazeState, operator:Operator): MazeState
    {

        var pokemonLocations:Array<Int> = [for (i in 0...state.getPokemonsLocations().length) state.getPokemonsLocations()[i]];    
     
        var newState:MazeState = new MazeState({x:state.getPosition().x, y:state.getPosition().y}, state.getDirection(), 
                                                pokemonLocations, state.getHatchingDistanceLeft());

        //TODO do map checks
        switch(operator)
        {
            case Operator.MoveForward:
                switch(state.getDirection())// TODO validate  after deciding a refernce point
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

            case Operator.RotateLeft:
                newState.setDirection(Type.createEnumIndex(Direction, (Type.enumIndex(state.getDirection())-1+4)%4));
            case Operator.RotateRight:
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
}