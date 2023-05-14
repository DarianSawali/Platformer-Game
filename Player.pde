//This is a sub class of Character to make the player
class Player extends Character {
  float damp = 0.9;
  int hitTimer = 0;
  float jump = 0.8;
  boolean jumping = false;
  float ySpeed = 0;
  float left = PI;
  PVector dim;
  float timer = 0;
  PImage lArrow, rArrow;
  float animationRate = 2;
  //Aggregation
  ArrayList<Arrow> bullets = new ArrayList<Arrow>();
  
  Player(PVector pos, PImage aimg){
    super(pos, aimg);
    this.vel = new PVector();
    img.resize(0, 144);
    activeFrames = archerStandr;
    dim = new PVector(110, 144);
    lArrow = loadImage("lArrow.png");
    rArrow = loadImage("rArrow.png");
    oWidth = 110;
    oHeight = 144;
    health = 200;
  }
  
  //Overriding Polymorphism
  //method that makes character move
  void move(){
    super.moveCharacter();
    vel.mult(damp); 
  }
    
  //calls other methods within the method
  void update(){
    super.checkWalls(); 
    updateFrame();
    move();
    checkProjectiles();
    checkBlock();
    if(vel.y == 0) numJumps = 0;
    if(health <= 0){
      state = LOSE; 
      playSound(LOSES);
    }
    if(pos.x > 2600 && enemies.size() == 0){
      clearLevel(); 
    }
    
  }
  
  //these functions call which activeFrames are currently being used making it animated
  void runr(){
    activeFrames = archerRunr; 
  }
  void runl(){
    activeFrames = archerRunl; 
  }
  void jumpr(){
    activeFrames = archerJumpr; 
  }
  void standr(){
    activeFrames = archerStandr; 
  }
  void standl(){
    activeFrames = archerStandl; 
  }
  void shootr(){
    activeFrames = archerShootr; 
  }
  void shootl(){
    activeFrames = archerShootl; 
  }

  //method makes player shoot arrow along with adding sound effects
  void fire(){
    playSound(SHOOT);
    if(right == true)
      bullets.add(new Arrow(new PVector(pos.x + dim.x/2, pos.y + dim.y/2), new PVector(20, 0), rArrow));
    if(right == false)
      bullets.add(new Arrow(new PVector(pos.x, pos.y + dim.y/2), new PVector(-20, 0), lArrow));
  }
  
  //method clears previous level and sets up the next level by spawning enemies and health packs along with repositioning the player
  void clearLevel(){
    enemies.clear();
    reposition();
    state++;
    switch(state){
      case LEVEL_TWO:
        L1.blocks.clear();
        L2 = new Level_2();
        for (int i = 0; i < 4; i++) {
          addEnemy(random(650, 2000), 40);
        }        
      break;
      case LEVEL_THREE:
        L2.blocks.clear();
        L3 = new Level_3();
        for (int i = 0; i < 7; i++) {
          addEnemy(random(650, 2000), 40);
        }
        for (int i = 0; i < 1; i++) {
          addHealth(1300, 0);
        }
      break;
      case LEVEL_FOUR:
        L3.blocks.clear();
        LB = new Level_Boss();
        for (int i = 0; i < 1; i++) {
          addBoss(2200, 0);
        }
        for (int i = 0; i < 1; i++) {
          addHealth(1300, 0);
        }
        
      break;
      case WIN:
        playSound(WINS);
      break;
    }
  }
    
  //makes player jump and falls back down again using gravity
  void playerJump(){
    pos.y += ySpeed;
    jumping = true;
    if(jumping == true){
      timer++;
      if(timer >= 1){
        jumping = false;
        timer = 0;
        
      }
    }
    
  }
  
  //checks whether the arrow hits enemy or not and removes it if so
  void checkProjectiles(){
    for(int i = 0; i < bullets.size(); i++){
      Arrow b = bullets.get(i);
      b.update();
      b.drawMe();
      
      for(int j = 0; j < enemies.size(); j++){
        Enemy e = enemies.get(j);
        b.shot(e);
      }      
      if(!b.isAlive){
         bullets.remove(i);
      } 
    }
  }
  
  //repositions player after level change
  void reposition(){
    pos.x = 100;
    pos.y = 0;
  }

  //turns the player right and left to change walking and shooting direction
  void drawMe(){
    if(right == true){
      pushMatrix();
      translate(pos.x, pos.y);
      //rect(0,0, dim.x, dim.y);
      image(img, 0, 0); 
      popMatrix();
    }
    if(right == false){
      pushMatrix();
      translate(pos.x, pos.y);
      //rect(0,0,dim.x,dim.y);
      image(img, 0, 0); 
      popMatrix();
    }
  }
  
  //draws health bar on top of character
  void drawHealth(){
    pushMatrix();
    translate(pos.x - 50, pos.y - 20);
    fill(214, 11, 11);
    rect(0, 0, health, 10);
    popMatrix(); 
  }
  
   
  
  //method also checks if player is colliding with blocks or not by using blocks as parameter
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
          } else {
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

  
  
}
