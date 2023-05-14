//This is a superclass that helps make the projectiles that shoots out in the game
class Projectile {
  PVector pos, vel, dim;
  boolean isAlive;

  
  Projectile(PVector pos, PVector vel){
    this.pos = pos;
    this.vel = vel;
    dim = new PVector(25, 5);
    isAlive = true;
  }
  
  //the method makes the projectile move
  void move(){
    pos.add(vel); 
  }
  
  //the method determines whether the projectile is out of bounds or not
  void handleWalls(){
    if(abs(pos.x-width/2) > width + 700 || abs(pos.y-height/2) > height/2){
      isAlive = false; 
    }
  }
  
  //the method calls the other methods to be used
  void update(){
    move();
    handleWalls();
  }
  
  //determines whether the enemy is shot by this projectile or not and decreases health if so
  void shot(Enemy e){
    if(hit(e)){
      e.decreaseHealth(1);
      e.vel.x *= 0.9;
      e.vel.y *= 0.9;
      isAlive = false;
      if(e.health == 0){
        e.shot();
        e.update();
      }
    }
  }
  
  //checks if the projectile has collision with enemy or not
  boolean hit(Character e){
    boolean shot = false;
    if(abs((e.pos.x + e.img.width/2)-pos.x)<e.img.width/2 + dim.x && abs((e.pos.y + e.img.height/2) - pos.y) < e.img.height/2 + dim.y/2){
      shot = true;
    }
    return shot;
  }
  
  
  void drawMe(){
    pushMatrix();
    translate(pos. x, pos.y);
    noStroke();
    fill(255);
    ellipse(0, 0, dim.x, dim.y);
    popMatrix();
  }
  
}
