class Enemy extends Character {
  int removeTimer = -1; //timer that removes enemy when killed
  boolean hit = false; //checks if hit or not
  PVector acc; //acceleration PVector
  float gravity = 7; //gravity that registers for the enemy
  
  
  Enemy(PVector pos, PImage img, PVector vel){
    super(pos, img);
    this.vel = vel;
    acc = new PVector(0, 0);
    activeFrames = demonStand;
    img.resize(0, 144);
    dim = new PVector(110, 144);
    oWidth = 110;
    oHeight = 144;
    health = 5;
    
  }
  
  //method that animates the run of enemies
  void movement(){
    if(vel.x > 0){
      runr();
    }
    else if(vel.x < 0){
      runl(); 
    }
  }
  
  //method that makes enemy follow the enemy
  void follow(){
    PVector dir = PVector.sub(player.pos, pos);
    dir.normalize();
    acc = dir;
    vel.add(acc);
    vel.limit(random(1, 4));
    pos.add(vel); 
  }
  
  //Overriding Polymorphism
  //calls other methods for enemy to function
  void update(){
    super.update();
    updateFrame();
    movement();
    checkBlock();
    follow();
    if(removeTimer > 0){
      removeTimer--;
      vel.x = 0;
      vel.y = 0;
    }
    if(removeTimer == 0){
      killed(); 
      score.scoreUpdate(100);
    }
  }
  
  //these functions call which activeFrames are currently being used making it animated
  void runr(){
    activeFrames = demonRunr; 
  }
  void runl(){
    activeFrames = demonRunl; 
  }
  void dying(){
    activeFrames = demonDying;
  }
  
  
  //checks if enemy is alive or not
  boolean isAlive(){
    return removeTimer == -1;
  }
  
  //checks whether if enemy is shot or not and makes them stop in place if so and registers a timer for death animation
  boolean shot(){
    boolean shot = false;
    if(isAlive()){
      removeTimer = 45;
      vel.x = 0;
      vel.y = 0; 
      shot = true;
    }
    return shot;
  }
  
  //checks whether if enemy collides with player or not and plays hurt sound effect if so
  void hitPlayer(){
    if(!hit){
      playSound(HURT);
      player.decreaseHealth(10); 
    }
  }
  
  //method that removes enemy if killed
  void killed(){
    enemies.remove(this);
  }
  
 
  void drawMe(){
    if(isAlive()){   
      pushMatrix();
      translate(pos.x, pos.y);
      image(img, 0, 0); 
      popMatrix();
    }
    else{
      pushMatrix();
      translate(pos.x, pos.y);
      dying();
      image(img, 0, 0);
      popMatrix();
    }
  }
  
}
