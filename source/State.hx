package;

class State
{
	
	xLocation: Int;
	yLocation: Int;
	pokemon: Bool;
	
  	public function new() { }

	public function new(xLocation: Int, yLocation: Int): Void 
	{
	this.xLocation  = xLocation;
	this.yLocation = yLocation;
	}

	public function getXLocation(): Int
	{
	return this.xLocation;
	}

	public function getYLocation(): Int
	{
	return this.yLocation;
	}
	
	public function setXLocation(xLocation: Int): Void
	{
	this.xLocation = xLocation;
	}

	public function setYLocation(yLocation: Int): Void
	{
	this.yLocation = yLocation;
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