//superclass that sets up the gameworld
class GameWorld {

  static final int TILE_EMPTY = 0;  
  static final int TILE_BLOCK = 1;  
  
  static final int TILE_SIZE = 80;
  static final int HEALTH_SIZE = 40;
  
  ArrayList<Block> blocks = new ArrayList<Block>();

  GameWorld() {

  }

  //draws block
  void drawMe(Character c){
    for(int i = 0; i < blocks.size(); i++){
      Block b = blocks.get(i);
      b.drawMe(c);
    }
  }
  
}
