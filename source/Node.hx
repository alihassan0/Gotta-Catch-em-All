package;

import State;

class Node
{

	var state: State;
	var parent: Node;

	public function new() { }

	public function new(state: State, parent: Node): Void 
	{
	this.state  = state;
	this.parent = parent;
	}

	public function getState(): State
	{
	return this.state;
	}	

	public function getParent(): Node
	{
	return this.parent;
	}	

	public function setState(state: State): Void
	{
	this.state = state;
	}	

	public function setParent(parent: Parent): Void
	{
	this.parent = parent;
	}	

}