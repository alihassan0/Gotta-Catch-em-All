package gui; 

import flixel.FlxSprite;
import flixel.FlxG;

class GuiTile extends FlxSprite
{
    public function new (x:Int, y:Int)
    {
        //TODO : Add DRY functions to change sprites
        super(x, y);
        loadGraphic("assets/images/spritesx2.png", true, Reg.tileSize, Reg.tileSize, true);
        this.animation.frameIndex = 32;
        FlxG.state.add(this);
    }
}