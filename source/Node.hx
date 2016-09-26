package;

import State;

class Node
{

	var state: State;
	var parent: Node;

	public function new() { }

	public function new(state: State, parent: Node) 
	{
	this.state  = state;
	this.parent = parent;
	}

}