package ai;

import de.polygonal.ds.PriorityQueue;
import util.*;

class MazeSearcher
{
    private static var depth:Int = 0 ;
 	public static function search(maze:Maze, strategy:Strategy, visualize:Bool):PriorityQueue<Node>
	{
        //create Node double ended queue
        var queue:PriorityQueue<Node> = new PriorityQueue<Node>();

        trace( "initialState => ", maze.initialState );
        //push root Node with no parent
        queue.enqueue(makeNode(maze.initialState));

        while(true)
        {
            if(queue.isEmpty())
                return null;
            
            var node:Node = queue.dequeue();
            depth ++;//temp
            if(maze.goalTest(node.getState()))
            {
                trace("Goal Found after ", depth, " trials" );
                var path:Array<State> = new Array<State>();
                while(node.getParent() != null)
                {
                    path.push(node.getState());
                    node = node.getParent();
                }
                trace("Goal Found at depth :", path.length);
                trace("-----------------------------------");
                for (i in 0...path.length)
                {
                    trace(path[i]);
                }
                 return null;
            }   
            
            //TODO : Add queueing function here
            var newStates = expand(maze, node, maze.operators);
            for (i in 0...newStates.length)
            {
                var cost = node.getPathCost();
                
                switch (strategy)
                {
                    case Strategy.BreadthFirst:
                        cost += 1; 
                    case Strategy.DepthFirst:
                        cost -= 1; 
                    default :

  
                }
                queue.enqueue(makeNode(newStates[i], node, cost));
            }

        }
	}
    public static function makeNode (state: State, ?parent:Node, pathCost:Float = 0): Node
	{
        return new Node(state, parent, pathCost);
	}
    public static function expand (maze:Maze, node:Node, operators:Array<Operator>): Array<State>
    {
        var validStates:Array<State> = new Array<State>();
        for (i in 0...operators.length)
        {
            var state:State = apply(node.getState(), operators[i]); 
            if(maze.isValidState(state) && isNotLoop(node, state))
            {
                //trace(state," operator => ", operators[i]);
                validStates.push(state);
            }
        }
        return validStates;
    }
    public static function isNotLoop (node:Node, state:State): Bool
    {
        while(node.getParent() != null)
        {
            if(node.getState().equals(state))
                return false; // it's A trap .. Ignore this loop :D
            node = node.getParent();
        }
        return true;
    }
    public static function apply (state:State, operator:Operator): State
    {
        var newState:State = new State({x:state.getPosition().x, y:state.getPosition().y}, state.getDirection());
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
}
