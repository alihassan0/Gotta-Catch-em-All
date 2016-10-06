package ai.base;

import util.*;

class Problem <T:State>
{
    //problem tuples
    public var operators:Array<Operator>;
    public var initialState:T;
    private var heuristicFunctions:Array<T->Int>;

    public function new ()
    {  
        heuristicFunctions = new Array<T->Int>();
    }

    //TODO I have no idea what this takes for now
    public function calculatePathCost ()
    {

    }
    
    public function setInitialState ()
    {

    }

    public function isValidState (state:T):Bool
    {
        return true;
    }

    public function goalTest (state:T): Bool
    {
        return false;
    }

    public function apply (state:T, operator:Operator): T
    {
        return null;
    }
    
    public function getHeuristic (state:T, heuristicFunctionIndex:Int): Int
    {
        var heuristicFunction = heuristicFunctions[heuristicFunctionIndex-1];

        if (heuristicFunction != null)
            return heuristicFunction(state);
        else
            throw "Heurestic Id wasn't found";
    }

}