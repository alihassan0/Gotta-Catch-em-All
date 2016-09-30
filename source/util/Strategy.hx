package util;

enum Strategy {
  BreadthFirst;
  DepthFirst;
  IterativeDeapening;
  UniformCost;
  Gready(id:Int);
  AStar(id:Int);
}