package gui; 

import flixel.FlxSprite;
import flixel.FlxG;
import util.*;

class GuiAgent extends FlxSprite
{
    private var position:Point;
    private var direction:Direction;

    private var guiMaze:GuiMaze;

    public function new (x:Int, y:Int, guiMaze:GuiMaze)
    {
        //TODO : Add DRY functions to change sprites
        super(x, y);
        this.guiMaze = guiMaze;

        loadGraphic("assets/images/spritesx2.png", true, Reg.tileSize, Reg.tileSize, true);
        FlxG.state.add(this);
        position = {x:0, y:0};
    }

    public function moveTo(x:Int, y:Int)
    {
        position.x = x;
        position.y = y;
        trace(x,y, Reg.mapOffset.x + y*Reg.tileSize, Reg.mapOffset.y + x*Reg.tileSize);
        reset(Reg.mapOffset.x + y*Reg.tileSize, Reg.mapOffset.y + x*Reg.tileSize);
    }
    public function setDirection(direction:Direction)
    {
        this.direction = direction; 
        //todo implement facing
        switch(direction)
        {
            case Direction.North:
                this.animation.frameIndex = 6;

            case Direction.East:
                this.animation.frameIndex = 3;

            case Direction.South:
                this.animation.frameIndex = 0;
            
            case Direction.West:
                this.animation.frameIndex = 3;
        }
    }
    
    public function apply(operator:Operator)
    {
        switch(operator)
        {
            case Operator.MoveForward:
                
                //update position 
                switch(direction)
                {
                    case Direction.North:
                        moveTo(position.x -1, position.y);

                    case Direction.East:
                        moveTo(position.x , position.y +1);

                    case Direction.South:
                        moveTo(position.x +1, position.y);
                    
                    case Direction.West:
                        moveTo(position.x , position.y -1);
                }
                //if the new state contains pokemon remove it from it's array; 
                guiMaze.collectPokemon(position.x, position.y);

                //decrement time to left to hatch the egg
                //newState.decrementHatchingDistanceLeft();

            case Operator.RotateLeft:
                //change direction
                setDirection(Type.createEnumIndex(Direction, (Type.enumIndex(direction)-1+4)%4));
                
            case Operator.RotateRight:
                //change direction
                setDirection(Type.createEnumIndex(Direction, (Type.enumIndex(direction)+1+4)%4));
        }
        trace(operator, position, direction);
    }
    public function followPath(operators:Array<Operator>)
    {
        if(operators.length> 0)
        {
            var operator = operators.shift();
            apply(operator);
            haxe.Timer.delay(followPath.bind(operators), 200); 
            guiMaze.isFollowingPath = true;
        }
        else
            guiMaze.isFollowingPath = false;
    }
    public function resetStats()
    {
        var pos = guiMaze.maze.toPoint(guiMaze.maze.agentPos);
        moveTo(pos.x, pos.y);
        setDirection(guiMaze.maze.agentDirection);
    }


}