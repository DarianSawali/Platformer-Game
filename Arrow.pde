//This is a sub class which is an extension of Projectile which makes the arrow shoot
class Arrow extends Projectile {
  PImage img;

  
  Arrow(PVector pos, PVector vel, PImage img){
    super(pos, vel);
    this.img = img;
    dim = new PVector(90, 19);
    isAlive = true;
  }
  
  
  void drawMe(){
    pushMatrix();
    translate(pos.x, pos.y);
    //rect(0, 0, dim.x, dim.y);
    image(img, 0, 0);
    popMatrix();
  }
  
}
