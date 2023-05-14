//This tab holds the input of the keys 
int numJumps = 0;

void keyPressed(){
  if(key == 'd' || key == 'D'){ 
    player.right = true;
    right = true;
    player.runr();
  }
  if(key == 'a' || key == 'A'){
    player.right = false; 
    left = true;
    player.runl();
  }
  if(key == ' ' && !player.jumping) {
    numJumps++;
    if(numJumps <= 1)
      player.vel.y += -90;
    player.jumping = true;
    if(player.right == true){
      player.jumpr();
    }
  }
  if(key == CODED){
    if(keyCode == SHIFT) 
      player.fire();
      if(player.right == true){
        player.shootr();
      }
      else{
        player.shootl();
      }
  }
}

void mousePressed(){
  player.fire();
  if(player.right == true){
    player.shootr();
  }
  else{
    player.shootl();
  }
}

void mouseReleased(){
  if(player.right == true){
    player.standr();
  }
  else{
    player.standl();
  }
}

void keyReleased(){
  if(key == 'd' || key == 'D'){
    right = false;
    player.standr();
  }
  if(key == 'a' || key == 'A'){
    left = false;
    player.standl();
  }
  if(key == ' ') player.jumping = false;
  
  if(key == CODED){
    if(keyCode == SHIFT) 
      if(player.right == true){
        player.standr();
      }
      else{
        player.standl();
      }
  }
}
