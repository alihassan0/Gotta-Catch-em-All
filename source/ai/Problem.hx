package ai;

import util.*;

class Problem
{
    //problem tuples
    public var operators:Array<Operator>;
    public var initialState:State;

    public function new ()
    {  
        
    }

    //TODO I have no idea what this takes for now
    public function calculatePathCost ()
    {

    }
    
    public function setInitialState ()
    {

    }

    public function isValidState (state:State):Bool
    {
        return true;
    }

    public function goalTest (state:State): Bool
    {
        return false;
    }
}