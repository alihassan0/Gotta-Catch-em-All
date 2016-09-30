package ai;

import util.*;

class State
{
	
	private var position: Point;
	private var direction: Direction;
	private var pokemon: Bool;
	

	public function new(position: Point, direction: Direction): Void 
	{
		this.position = position;
		this.direction = direction;
	}

	public function setPosition(position:Point): Void
	{
		this.position = position;
	}

	public function getPosition():Point
	{
		return this.position;
	}
	
	public function setDirection(direction:Direction): Void
	{
		this.direction = direction;
	}

	public function getDirection():Direction
	{
		return this.direction;
	}

	public function getPokemon(): Bool
	{
		return this.pokemon;
	}

	public function setPokemon(pokemon: Bool): Void
	{
		this.pokemon = pokemon;
	}
}