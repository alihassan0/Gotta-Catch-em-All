package gui; 

import flixel.FlxSprite;
import flixel.FlxG;

class GuiTile extends FlxSprite
{
    public function new (x:Int, y:Int)
    {
        super(x +1, y +1);
        makeGraphic(Reg.tileSize -2, Reg.tileSize-2, 0xFFFF0000);
        FlxG.state.add(this);
    }
}