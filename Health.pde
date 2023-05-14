//This is a sub-sub class which helps make the health pack 
class Health extends Enemy{
  boolean hit = false;
  
  Health(PVector pos, PImage img, PVector vel){
    super(pos, img, vel);
    activeFrames = healthPack;
    dim = new PVector(90, 64);
    img.resize(90, 64);
    oWidth = 90;
    oHeight = 64;
  }
 
  //checks whether player is colliding with health pack or not and adding health if so
  void hitPlayer(){
    if(!hit){
      playSound(HEALTH);
      player.decreaseHealth(-20); 
      enemies.remove(this);
    }
  }
  
  //calls other methods
  void update(){
    moveCharacter();
    checkBlock();
  }
  
  //these functions are to make sure that health pack has its own animation
  void runr(){
    activeFrames = healthPack; 
  }
  void runl(){
    activeFrames = healthPack; 
  }
  void dying(){
    activeFrames = healthPack;
  }
  
  void drawMe(){
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, 0, 0);
    popMatrix();
    
  }
  
}
