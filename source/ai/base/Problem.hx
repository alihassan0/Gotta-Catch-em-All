package ai.base;

import util.*;

class Problem <T:State>
{
    //problem tuples
    public var operators:Array<Operator>;
    public var initialState:T;

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
}