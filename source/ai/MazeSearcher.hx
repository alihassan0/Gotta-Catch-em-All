package ai;

import de.polygonal.ds.PriorityQueue;
import util.*;
import ai.base.*;

class MazeSearcher
{
 	    
    @:generic
 	public static function search<T:State>(problem:Problem<T>, strategy:Strategy, visualize:Bool):Array<Operator>
    {
        if(strategy == Strategy.IterativeDeapening)
        {
            var depth:Int = 0;
            while(true)
            {
                var result = hsearch(problem, strategy, visualize, depth);
                if ( result != null)
                    return result;
                
                depth ++;
            }
        }
        else
            return hsearch(problem, strategy, visualize);
    }
    @:generic
 	public static function hsearch<T:State>(problem:Problem<T>, strategy:Strategy, visualize:Bool, ?depth:Int= 0):Array<Operator>
	{
        //create Priority queue with nodes of type state
        var queue:PriorityQueue<Node<T>> = new PriorityQueue<Node<T>>(null, true);

        var nodesExplored:Int = 0;
        //trace( "initialState => ", problem.initialState );
        //push root Node with no parent
        queue.enqueue(makeNode(problem.initialState));
        while(true)
        {
            if(queue.isEmpty())
                return null;
            
            var node:Node<T> = queue.dequeue();
            nodesExplored ++;//temp
            if(problem.goalTest(node.getState()))
            {
                trace("--------------------- [["+strategy+"]] --------------------");
                trace("Goal Found after "+ nodesExplored+ " nodes Explored ");
                Reg.latestNodesExploredCount = nodesExplored;
                var path:Array<Operator> = new Array<Operator>();
                while(node.getParent() != null)
                {
                    path.push(node.getOperator());
                    node = node.getParent();
                }
                trace("Goal Found at depth :", path.length);
                path.reverse();
                //trace(path);

                trace("-----------------------------------------------------------\n");
                return path;    
            }   
            if(strategy == Strategy.IterativeDeapening && node.getDepth() > depth)
                return  null;
                
            //TODO : Add queueing function here
            var newNodes = expand(problem, node, problem.operators, strategy);
            for (i in 0...newNodes.length)
            {
                queue.enqueue(newNodes[i]);
            }

        }
	}

    @:generic
    public static function makeNode <T:State>(state: T, ?parent:Node<T>, ?pathCost:Float = 0, ?operator:Operator): Node<T>
	{
        var depth = parent != null? parent.getDepth() +1 : 0;
        return new Node<T>(state, parent, pathCost, operator, depth);
	}

    @:generic
    public static function expand <T:State>(problem:Problem<T>, node:Node<T>, operators:Array<Operator>, strategy:Strategy): Array<Node<T>>
    {
        var validNodes:Array<Node<T>> = new Array<Node<T>>();
        for (i in 0...operators.length)
        {
            var state:T = problem.apply(node.getState(), operators[i]); 
            if(problem.isValidState(state) && isNotLoop(node, state))
            {
                var cost = node.getPathCost();
                var heuristics = 0;
                
                switch (strategy)
                {
                    case Strategy.BreadthFirst:
                        cost += 1; 
                    case Strategy.DepthFirst:
                        cost -= 1;
                    case Strategy.Gready(id):
                        heuristics  = problem.getHeuristic(state,id);
                        cost = heuristics ;
                    case Strategy.AStar(id):
                        heuristics  = problem.getHeuristic(state,id);
                        cost += heuristics ;  
                    case Strategy.UniformCost:
                        cost += 1;
                    default :
                }
                validNodes.push(makeNode(state, node, cost, operators[i]));
            }
        }
        return validNodes;
    }

    @:generic
    public static function isNotLoop <T:State> (node:Node<T>, state:T): Bool
    {
        while(node.getParent() != null)
        {
            if(node.getState().equals(state))
                return false; // it's A trap .. Ignore this loop :D
            node = node.getParent();
        }
        return true;
    }
}
