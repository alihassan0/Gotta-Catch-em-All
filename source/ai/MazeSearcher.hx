package ai;

import de.polygonal.ds.ArrayedDeque;
import util.*;

class MazeSearcher
{
    private static var depth:Int = 5000 ;
 	public static function search(maze:Maze, strategy:String, visualize:Bool):ArrayedDeque<Node>
	{
        //create Node double ended queue
        var queue:ArrayedDeque<Node> = new ArrayedDeque<Node>();

        trace( "initialState => ", maze.initialState );
        //push root Node with no parent
        queue.pushBack(makeNode(maze.initialState));

        while(true)
        {
            if(queue.isEmpty())
                return null;
            
            var node:Node = queue.popFront();
            depth --;//temp
            //if(depth< 0) return false;
            trace(queue.size);
            if(maze.goalTest(node.getState()))
            {
                trace("Goal Found after", depth, "trials" );
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
                queue.pushBack(makeNode(newStates[i], node));
            }

        }
	}
    public static function makeNode (state: State, ?parent:Node): Node
	{
        return new Node(state, parent);
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
                        newState.getPosition().y --;

                    case Direction.East:
                        newState.getPosition().x ++;

                    case Direction.South:
                        newState.getPosition().y ++;
                    
                    case Direction.West:
                        newState.getPosition().x --;

                }

            case Operator.RotateLeft:
                newState.setDirection(Type.createEnumIndex(Direction, (Type.enumIndex(state.getDirection())-1+4)%4));
            case Operator.RotateRight:
                newState.setDirection(Type.createEnumIndex(Direction, (Type.enumIndex(state.getDirection())+1+4)%4));
        }
        return newState;
    }    
}
