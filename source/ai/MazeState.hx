
package ai;

import util.*;
import ai.base.*;

class MazeState extends State
{
    private var position: Point;
	private var direction: Direction;
	private var pokemonsLocations: Array<Int>;
	private var hatchingDistanceLeft: Int;

	public function new(position: Point, direction: Direction, pokemonsLocations:Array<Int>, hatchingDistanceLeft:Int): Void 
	{
        super();
        this.position = position;
		this.direction = direction;
		this.pokemonsLocations = pokemonsLocations;
		this.hatchingDistanceLeft = hatchingDistanceLeft;
	}

	public function getDistanceFrom(point:Point)
	{
		return Math.floor(Math.abs(point.x - position.x) + 
							Math.abs(point.y - position.y));
	}

	//getters
	public function setPosition(position:Point): Void
	{
		this.position = position;
	}

	public function getPosition():Point
	{
		return this.position;
	}
	
	public function getHatchingDistanceLeft():Int
	{
		return this.hatchingDistanceLeft;
	}
	
	public function decrementHatchingDistanceLeft():Int
	{
		return this.hatchingDistanceLeft - 1;
	}
	
	public function setDirection(direction:Direction): Void
	{
		this.direction = direction;
	}

	public function getDirection():Direction
	{
		return this.direction;
	}

	public function getPokemonsLocations(): Array<Int>
	{
		return this.pokemonsLocations;
	}

	public function setPokemonsLocations(pokemonsLocations: Array<Int>): Void
	{
		this.pokemonsLocations = pokemonsLocations;
	}
	public function toString() 
	{
        return "x ="+ position.x+ ", y ="+ position.y + ", direction ="+ direction ;
    }	
	override public function equals(state:State) 
	{
		var mazeState:MazeState = cast state;
        return mazeState.getPosition().x == this.getPosition().x 
				&&mazeState.getPosition().y == this.getPosition().y 
				&&mazeState.getDirection() == this.getDirection() 
				&&mazeState.getPokemonsLocations().toString() == this.getPokemonsLocations().toString();
				//todo sorting before serializingn
    }	
}