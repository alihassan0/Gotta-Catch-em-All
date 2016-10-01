package ai;

import util.*;

class Node implements de.polygonal.ds.Prioritizable
{
	//Node 5 tuples
	var state: State;
	var parent: Node;
	var operator:Operator;
	var pathCost:Float;
	var depth:Int;


	//interface properties 
	public var priority:Float;
	public var position:Int;

	public function new(state: State, parent: Node, pathCost:Float = 0 , ?operator:Operator, depth:Int = 1): Void 
	{
		this.state  = state;
		this.parent = parent;
		this.priority = pathCost;
		this.pathCost = pathCost;
		this.operator = operator;
		this.depth = depth;

	}

	public function getState(): State
	{
		return this.state;
	}	

	public function getParent(): Node
	{
		return this.parent;
	}	

	public function getPathCost(): Float
	{
		return this.pathCost;
	}	
	public function getDepth(): Int
	{
		return this.depth;
	}	
	public function getOperator(): Operator
	{
		return operator;
	}	

	public function setState(state: State): Void
	{
		this.state = state;
	}	

	public function setParent(parent: Node): Void
	{
		this.parent = parent;
	}

}