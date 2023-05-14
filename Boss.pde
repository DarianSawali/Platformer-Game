//This is a sub-sub class which extends from the Enemy sub class to make the boss
class Boss extends Enemy{
  //Aggregation
  ArrayList<Fireball> ball = new ArrayList<Fireball>();
  
  Boss(PVector pos, PImage img, PVector vel){
    super(pos, img, vel);
    activeFrames = boss;
    img.resize(0, 720);
    dim = new PVector(550, 720);
    animationRate = 9;
    oWidth = 550;
    oHeight = 720;
    health = 50;
  }
  
  //method that fires fireballs every certain amount of time
  void fire() {
    if (frameCount % 180 == 0 && ball.size() == 0) {
      playSound(FIREBALL);
      ball.add(new Fireball(new PVector(pos.x + (img.width/4), pos.y + (img.height/2)), new PVector(-3, 0), fireball));
    }
  }
  
  //method that checks whether boss is shot and killed or not
  boolean shot(){
    boolean shot = false;
    if(isAlive()){
      removeTimer = 135;
      vel.x = 0;
      vel.y = 0; 
      shot = true;
    }
    return shot;
  }
  
  //method that checks whether the fireball hits or not
  void checkBall(){
    for (int i = 0; i < ball.size(); i++) {
      Fireball f = ball.get(i);
      f.update();
      f.drawMe();
      f.hitPlayer(player, ball);
    }
  }
  
  //these functions call which activeFrames are currently being used making it animated
  void runr(){
    activeFrames = bossRunr; 
  }
  void runl(){
    activeFrames = bossRunl; 
  }
  void drawDying(){
    activeFrames = bossDying; 
  }
  
  //Overriding Polymorphism
  //method that makes the boss follow player but limits speed to 1
  void follow(){
    super.follow();
    PVector dir = PVector.sub(player.pos, pos);
    dir.normalize();
    acc = dir;
    vel.add(acc);
    vel.limit(1);
    pos.add(vel); 
  }
  
  //method that calls other methods
  void update(){
    super.update();
    fire();
    updateFrame();
    checkBall();
    checkBlock();
    if(removeTimer > 0){
      removeTimer--;
    }
    if(removeTimer == 0){
      killed(); 
      score.scoreUpdate(700);
    }
  }
  
  void drawMe(){
    if(isAlive()){   
      pushMatrix();
      translate(pos.x, pos.y);
      //rect(0, 0, dim.x, dim.y);
      image(img, 0, 0); 
      popMatrix();
    }
    else{
      pushMatrix();
      translate(pos.x, pos.y);
      drawDying();
      image(img, 0, 0);
      popMatrix();
    }
  }
  
  
}
