package ai;

import util.*;
import ai.base.*;

class Node<T:State> implements de.polygonal.ds.Prioritizable
{
	//Node 5 tuples
	var state: T;
	var parent: Node<T>;
	var operator:Operator;
	var pathCost:Float;
	var depth:Int;
	var heuristic :Int;


	//interface properties 
	public var priority:Float;
	public var position:Int;

	public function new(state: T, parent: Node<T>, pathCost:Float = 0 , ?operator:Operator, depth:Int = 1): Void 
	{
		this.state  = state;
		this.parent = parent;
		this.priority = pathCost;
		this.pathCost = pathCost;
		this.operator = operator;
		this.depth = depth;

	}

	public function getState(): T
	{
		return this.state;
	}	

	public function getParent(): Node<T>
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

	public function setState(state: T): Void
	{
		this.state = state;
	}	

	public function setParent(parent: Node<T>): Void
	{
		this.parent = parent;
	}

	public function getHeuristic(): Int
	{
		return this.heuristic;
	}

	public function setHeuristic(heuristic:Int): Void
	{
		this.heuristic  = heuristic ;
	}

}
