package ai;

import de.polygonal.ds.ArrayedDeque;
import util.*;

class MazeSearcher
{
 	public static function search(maze:Maze, strategy:String, visualize:Bool):Bool
	{
        //create Node double ended queue
        var queue:ArrayedDeque<Node> = new ArrayedDeque<Node>();
        
        //push root Node with no parent
        queue.pushBack(makeNode(maze.initialState));

        while(true)
        {
            if(queue.isEmpty())
                return false;
            
            var node:Node = queue.popFront();
            
            if(goalTest(maze, node.getState()))
                return true;
            
            //TODO : Add queueing function here
            var newStates = expand(node.getState(), maze.operators);
            for (i in 0...newStates.length)
            {
                queue.pushBack(makeNode(newStates[i], node));
            }

        }

		return true;
	}
    public static function makeNode (state: State, ?parent:Node): Node
	{
        return new Node(state, parent);
	}
    public static function goalTest (maze: Maze, state:State): Bool
    {
        return false;
    }
    public static function expand (state:State, operators:Array<Operator>): Array<State>
    {
        var states:Array<State> = new Array<State>();
        for (i in 0...operators.length)
        {
            states.push(apply(state, operators[i]));
        }
        return states;
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
