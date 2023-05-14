//This is a super class which helps make the player and enemy class
class Character {
  PVector pos, vel, dim; 
  float oWidth, oHeight, health; 
  float gravity = 5; //holds the value of gravity
  PImage img;
  boolean right, left; //helps character differentiate left and right 
  float animationRate = 3; //the speed of the change of frames in animation
  int currFrame = 0; //which current frame that is being displayed
  PImage[] activeFrames; //array that holds which animation is currently active
  
  Character(PVector pos, PImage img){
    this.pos = pos;
    this.img = img;
  }
  
  //method that registers the gravity
  void moveCharacter(){
    pos.add(vel); 
    vel.y += gravity;
  }
  
  //method that makes player move
  void accelerate(PVector force) {
    vel.add(force);
  }
  
  //method that takes float which decreases health
  void decreaseHealth(float damage){ 
    health -= damage;
  }
  
  //method that checks bounds
  void checkWalls(){
    if (pos.x<img.width/2)
      pos.x=img.width/2;
  }
  
  //method that calls other methods
  void update(){
    moveCharacter();
    checkWalls();
  }
  
  //method that checks the parameter of a character if they collide with eachother or not
  boolean hitCharacter(Character e){
    boolean hit = false;
    if(abs(pos.x -e.pos.x) < oWidth/2 + e.dim.x/2 && abs(pos.y - e.pos.y) < oHeight/2 + e.dim.y/2){
      hit = true;
    }
    return hit;
  }
  
  void drawMe(){

  }
  
  //method that switches between frames which makes characters look animated
  void updateFrame() {
    if (frameCount % animationRate == 0) { //Display each image for 6 frames before switching to the next 
      if (currFrame < activeFrames.length-1) //if within array length
        currFrame++;                        //switch to the next image
      else 
      currFrame = 0; //if reaching the end of the array restart from the begining

      img = activeFrames[currFrame];
    }
  }
  
  //method that takes block as parameter and checks whether character is colliding with blocks or not
  void worldCollisions(Block r2) {
    float distX = (pos.x + dim.x/2) - (r2.pos.x +r2.dim.x/2);
    float distY = (pos.y +dim.y/2) - (r2.pos.y +r2.dim.y/2);
    float halfWidths = (dim.x/2) + (r2.dim.x/2);
    float halfHeights = (dim.y/2) + (r2.dim.y/2);


    if (abs(distX) < halfWidths) {
      if (abs(distY) < halfHeights) {

        float overlapX = halfWidths - abs(distX);
        float overlapY = halfHeights - abs(distY);
        if (overlapX >= overlapY) {
          if (distY > 0) {
            pos.y +=overlapY; //dectection for under block
            //player.jumping = true;
            } 
          else {
            pos.y -= overlapY;
            vel.y = 0; 
          }
        } else if (overlapX <= overlapY) {
          if (distX > 0) {
            pos.x +=overlapX;
          } else {
            pos.x -=overlapX;

          }
        }
      }
    }
  }
  
  
  //method that makes sure the characters are stopped by the blocks
  void checkBlock(){
    switch(state){
      case LEVEL_ONE:
        for(int i = 0; i < L1.blocks.size(); i++){
          Block b = L1.blocks.get(i);
          worldCollisions(b);
        }
      break;
      case LEVEL_TWO:
        for(int i = 0; i < L2.blocks.size(); i++){
          Block b = L2.blocks.get(i);
          worldCollisions(b);
      }
      break;
      case LEVEL_THREE:
        for(int i = 0; i < L3.blocks.size(); i++){
          Block b = L3.blocks.get(i);
          worldCollisions(b);
      }
      break;
      case LEVEL_FOUR:
        for(int i = 0; i < LB.blocks.size(); i++){
          Block b = LB.blocks.get(i);
          worldCollisions(b);
      }
      break;
      
    }
  }
}
