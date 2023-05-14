//This class is for making the platforms
class Block {
  PVector pos, dim;
  Block(PVector pos, PVector dim) {
    this.pos = pos;
    this.dim = dim;
  }
  
  //checks whether player is in collision with block or not
  boolean check(Character c) {
    if (abs(c.pos.x - (pos.x - c.pos.x)) < c.dim.x / 2 + dim.x / 2 && abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2) {
      //player.jumping = false;
      return true;
    }
    return false;
  }

  void drawMe(Character c) {
    pushMatrix();
    fill(0);
    rect(pos.x,pos.y,dim.x,dim.y);
    popMatrix();
  }
}
