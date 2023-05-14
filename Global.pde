//global tab which holds many methods to help run the game
final int START = 0;
final int STORY = 1;
final int LEVEL_ONE = 2; 
final int LEVEL_TWO = 3;
final int LEVEL_THREE = 4;
final int LEVEL_FOUR = 5;
final int WIN = 6;
final int LOSE = 7;

final String SHOOT = "shoot.wav";
final String FIREBALL = "fireball.wav";
final String HEALTH = "pickup.wav";
final String HURT = "hurt.wav";
final String WINS = "won.wav";
final String LOSES = "lost.wav";
final String AMB = "amb.wav";

import ddf.minim.*;
Minim minim;
AudioPlayer shoot, hurt, fire, pack, won, lost, amb;

import controlP5.*;
ControlP5 controlP5;
Button play, menu, go;

Player player;
Score score;
GameWorld gw;
Level_1 L1;
Level_2 L2;
Level_3 L3;
Level_Boss LB;

PImage avt, enemy, health, boss1, fireball, bg;
PVector leftAcc = new PVector(-1, 0);
PVector rightAcc = new PVector(1, 0);
boolean up, down, left, right;
int state;

PImage[]  archerRunr = new PImage[12];
PImage[]  archerRunl = new PImage[12];

PImage[]  archerStandr = new PImage[1];
PImage[]  archerStandl = new PImage[1];

PImage[]  archerJumpr = new PImage[6];
PImage[]  archerShootr = new PImage[2];
PImage[]  archerShootl = new PImage[2];

PImage[]  enemyMove =new PImage[1];

PImage[]  demonRunr = new PImage[12];
PImage[]  demonRunl = new PImage[12];
PImage[]  demonStand = new PImage[1];

PImage[]  demonDying = new PImage[15];

PImage[]  bossHurt = new PImage[12];
PImage[]  boss = new PImage[1];

PImage[]  bossRunr = new PImage[12];
PImage[]  bossRunl = new PImage[12];

PImage[]  bossDying = new PImage[15];

PImage[]  healthPack = new PImage[1];

//loads frames of player and enemies
void loadPlayerFrames(){
  loadFrames(archerRunr, "Archer_Run_");
  loadFrames(archerRunl, "lArcher_Run_");
  loadFrames(archerJumpr, "Archer_Jump_");
  loadFrames(archerStandr, "Archer_Run_");
  loadFrames(archerStandl, "lArcher_Run_");
  loadFrames(archerShootr, "Archer_Shoot_");
  loadFrames(archerShootl, "lArcher_Shoot_");
  
  loadFrames(demonRunr, "Demon_Run_");
  loadFrames(demonRunl, "lDemon_Run_");
  loadFrames(demonDying, "Demon_Dying_");
  loadFrames(demonStand, "Demon_Run_");
  
  bossFrames(bossHurt, "Boss_");
  bossFrames(boss, "Boss_");
  bossFrames(bossDying, "Boss_Dying_");
  
  bossFrames(bossRunr, "Boss_Run_");
  bossFrames(bossRunl, "lBoss_Run_");
  
  packFrames(healthPack, "Health_");
}

//adds enemies with parameters of both x and y position
void addEnemy(float x, float y){
  enemies.add(new Enemy(new PVector(x, y), enemy,  
  new PVector(random(-5, 5), 0)));
}

//Inclusion Polymorphism
//adds boss with parameters of both x and y position
void addBoss(float x, float y){
  enemies.add(new Boss(new PVector(x, y), boss1, new PVector(0, 0)));
}

//Inclusion Polymorphism
//adds health pack with parameters of both x and y position
void addHealth(float x, float y){
  enemies.add(new Health(new PVector(x, y), health, new PVector(0, 0)));
}

//takes PImage array and file names and loads image with a resized size
void loadFrames(PImage[] ar, String fname) {
  for (int i=0; i< ar.length; i++) {
    PImage frame=loadImage(fname+ i +".png");
    frame.resize(0, 144);
    ar[i]=frame;
  }
}

//takes PImage array and file names and loads image with a resized size
void bossFrames(PImage[] ar, String fname) {
  for (int i=0; i< ar.length; i++) {
    PImage frame=loadImage(fname+ i +".png");
    frame.resize(0, 720);
    ar[i]=frame;
  }
}

//takes PImage array and file names and loads image with a resized size
void packFrames(PImage[] ar, String fname) {
  for (int i=0; i< ar.length; i++) {
    PImage frame=loadImage(fname+ i +".png");
    frame.resize(90, 0);
    ar[i]=frame;
  }
}

//shows the start screen of the game
void startScreen(){
  background(bg);
  play.show();
  textSize(100);
  fill(255);
  textAlign(CENTER);
  text("Into The Night", width/2, height/2 - 200);
}

//shows the transition screen of the game with story
void storyScreen(){
  background(bg);
  go.show();
  textSize(50);
  fill(255);
  textAlign(CENTER);
  text("Your child has been kidnapped!!", width/2, height/2 - 200);
  text("Kill all enemies and retrive all health packs to advance in each level", width/2, height/2 - 120);
  text("Use 'A' and 'D' keys to move left and right respectively", width/2, height/2 - 40);
  text("Use 'Spacebar' to jump and 'Shift' or left 'Mouseclick' to shoot.", width/2, height/2 + 40);
}

//shows the win screen
void winScreen(){
  enemies.clear();
  menu.show();
  background(0);
  textSize(50);
  fill(255);
  textAlign(CENTER);
  text("YOU WIN!!!", width/2, height/2 - 200);
  text("You saved your child!", width/2, height/2 - 120);
  text("Time to go home.", width/2, height/2 - 40);
  text("Score : " + score.score, width/2, height/2 + 40);
}

//shows the lose screen
void loseScreen(){
  enemies.clear();
  menu.show();
  background(0);
  textSize(50);
  fill(255);
  textAlign(CENTER);
  text("YOU LOSE.!", width/2, height/2 - 200);
  text("Your child is still missing", width/2, height/2 - 120);
  text("Go back to menu and try again.", width/2, height/2 - 40);
  text("Score : " + score.score, width/2, height/2 + 40);
}

//method that starts level1
void game1(){
  background(bg);
  translate(-player.pos.x +400,0);
  L1.drawMe(player);
  player.update();
  player.drawMe();
  if (left) player.accelerate(leftAcc);
  if (right) player.accelerate(rightAcc);
  for (int i = 0; i < enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.update();
    e.drawMe();
    if(player.hitCharacter(e)){
      e.hitPlayer(); 
      e.hit = true;
    }
    else{
      e.hit = false; 
    }
  }
  score.drawScore(player);
  player.drawHealth();
}

//method that starts level2
void game2(){
  background(bg);
  translate(-player.pos.x +400,0);
  L2.drawMe(player);
  player.update();
  player.drawMe();
  if (left) player.accelerate(leftAcc);
  if (right) player.accelerate(rightAcc);
  for (int i = 0; i < enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.update();
    e.drawMe();
    if(player.hitCharacter(e)){
      e.hitPlayer(); 
      e.hit = true;
    }
    else{
      e.hit = false; 
    }
  }
  score.drawScore(player);
  player.drawHealth();
}

//method that starts level3
void game3(){
  background(bg);
  translate(-player.pos.x +400,0);
  L3.drawMe(player);
  player.update();
  player.drawMe();
  if (left) player.accelerate(leftAcc);
  if (right) player.accelerate(rightAcc);
  for (int i = 0; i < enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.update();
    e.drawMe();
    if(player.hitCharacter(e)){
      e.hitPlayer(); 
      e.hit = true;
    }
    else{
      e.hit = false; 
    }
  }
  score.drawScore(player);
  player.drawHealth();
}

//method that starts boss level
void gameBoss(){
  background(bg);
  translate(-player.pos.x +400,0);
  LB.drawMe(player);
  player.update();
  player.drawMe();
  if (left) player.accelerate(leftAcc);
  if (right) player.accelerate(rightAcc);
  for (int i = 0; i < enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.update();
    e.drawMe();
    if(player.hitCharacter(e)){
      e.hitPlayer(); 
      e.hit = true;
    }
    else{
      e.hit = false; 
    }
  }
  score.drawScore(player);
  player.drawHealth();
}

//method that plays sound effects
void playSound(String file) {
  AudioPlayer sound = null;
  switch(file) {
  case SHOOT: 
    sound = shoot;
    break;
  case HURT:
    sound = hurt;
    break;
  case HEALTH:
    sound = pack;
    break;
  case FIREBALL:
    sound = fire;
    break;
  case WINS:
    sound = won;
    break;
  case LOSES:
    sound = lost;
    break;
  }
  sound.play(0);
}

//controls the buttons of GUI and what they do
void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName() =="Play") { 
    menu.hide();
    state = STORY;
    play.hide();
  }
  
  if (theEvent.getController().getName() =="Go") { 
    state = LEVEL_ONE;
    go.hide();
    loadAssets();   
    for (int i = 0; i < 1; i++) {
      addHealth(600, 70);
    }
    for (int i = 0; i < 2; i++) {
      addEnemy(random(650, 2000), 40);
    }
    
  }
  
  if (theEvent.getController().getName() =="Menu") { 
    state = START;
    menu.hide();
  }
}
