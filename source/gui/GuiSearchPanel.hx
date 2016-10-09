package gui; 

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

import util.*;
import ai.*;


using flixel.util.FlxSpriteUtil;

class GuiSearchPanel extends FlxSprite
{
    private var strategyTxt:FlxText;
    private var nodesExploredCountTxt:FlxText;
    private var depthTxt:FlxText;

    private var searchBtn:FlxButton;
    private var followBtn:FlxButton;
    
    private var strategy:Strategy;
    private var guiMaze:GuiMaze;
    private var solutionPath:Array<Operator>;

    public function new (x:Int, y:Int, strategy:Strategy, guiMaze:GuiMaze)
    {
        //TODO : Add DRY functions to change sprites
        super(x, y+5);
        this.strategy = strategy;
        this.guiMaze = guiMaze;

        makeGraphic(150, 90, 0x00000000);
        var lineStyle:LineStyle = {color : 0xFFFF0000, thickness: 4.0};
        drawRoundRect(0,0, 150, 90, 30, 30, 0xFF00FF00, lineStyle);
        
        strategyTxt = new FlxText(x , y + 10, this.width, strategy+"")
                                .setFormat(Reg.font, 16, 0xFFFF0000, "center");

        searchBtn = new FlxButton(x, y+40, "search", search);
        followBtn = new FlxButton(x+75, y+40, "follow", follow);
        
        drawLine(0, 60, this.width,  60, lineStyle);
        drawLine(100, 60 , 100,  this.height, lineStyle);
        
        nodesExploredCountTxt = new FlxText(x , y + 65, 100, "nodes explored")
                                .setFormat(Reg.font, 12, 0xFFFF0000, "center");
        
        depthTxt = new FlxText(x +100 , y + 70, 50, "depth")
                                .setFormat(Reg.font, 12, 0xFFFF0000, "center");
        

        FlxG.state.add(this);
        FlxG.state.add(strategyTxt);
        FlxG.state.add(nodesExploredCountTxt);
        FlxG.state.add(depthTxt);

        FlxG.state.add(searchBtn);
        FlxG.state.add(followBtn);
    }
    function search()
    {

        guiMaze.maze.isSearching = true;
        solutionPath = MazeSearcher.search(guiMaze.maze, strategy ,  false);
        guiMaze.maze.isSearching = false;
        nodesExploredCountTxt.text = Reg.latestNodesExploredCount+ "";
        depthTxt.text = solutionPath.length +"";

    }
    function follow()
    {

        if(solutionPath != null)
        {
            guiMaze.resetStats();
            guiMaze.guiAgent.followPath(solutionPath);
        }
        else
            trace("there is no solution yet. you need to search first");

        
    }

}
