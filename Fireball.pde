//This is a sub class from Projectile which makes the projectile that comes out of the boss
class Fireball extends Projectile {
  PImage img;
  PVector acc;

  
  Fireball(PVector pos, PVector vel, PImage img){
    super(pos, vel);
    this.img = img;
    img.resize(180, 180);
    dim = new PVector(180, 180);
    isAlive = true;
  }
  
  
  //the method decreases player health when fireball has collision with the player along with playing sound effects
  void hitPlayer(Player p, ArrayList<Fireball> array) {
    if (abs((p.pos.x - p.img.width/2)- pos.x) < p.img.width/2 + dim.x && abs((p.pos.y - p.img.height/2) - pos.y) < p.img.height/2 + dim.y/2) {
      p.decreaseHealth(20);
      playSound(FIREBALL);
      playSound(HURT);
      print(p.health);
      array.remove(this);
    }
  }
  
  //Overriding Polymorphism
  //it makes the fireball move towards the player with a speed limit of 6
  void move(){
    super.move();
    PVector dir = PVector.sub(player.pos, pos);
    dir.normalize();
    acc = dir;
    vel.add(acc);
    vel.limit(5);
    pos.add(vel); 
  }
  
  
  void drawMe(){
    pushMatrix();
    translate(pos.x, pos.y);
    //rect(0, 0, dim.x, dim.y);
    image(img, 0, 0);
    popMatrix();
  }
}
