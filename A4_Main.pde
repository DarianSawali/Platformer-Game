

//Superclass -- Projectile, Character, GameWorld.
//Sub class -- Arrow and Fireball (Projectile), Player and Enemy (Character), all Level classes (GameWorld).
//Sub-Sub class -- Boss and Health (Enemy).
//Overriding Polymorphism -- located in some classes (sub classes) such as Player, Enemy, Boss, Fireball
//Inclusion Polymorphism used in spawning boss and health packs in Global tab
//Containment/Aggregation is seen in Player and Boss tab


ArrayList<Enemy> enemies = new ArrayList<Enemy>();

//sets up the buttons needed and basic setup
void setup(){
  
  size(1600, 900); 
  state = START;
  controlP5 = new ControlP5(this);
  PFont button = createFont("AgencyFB-Reg-48.vlw", 60, true);
  play = controlP5.addButton("Play", 0, width/2-140, height/2 + 100, 300, 100);
  play.getCaptionLabel().setFont(button);
  go = controlP5.addButton("Go", 0, width/2-140, height-200, 300, 100);
  go.getCaptionLabel().setFont(button);
  go.hide();
  menu = controlP5.addButton("Menu", 0, width/2-140, height-200, 300, 100);
  menu.getCaptionLabel().setFont(button);
  menu.hide();
   
  loadAssets();
}

//loads assets
void loadAssets(){
  PFont font = loadFont("AgencyFB-Bold-48.vlw");
  textFont(font);
  textSize(25);
  
  score = new Score();
  minim = new Minim(this);
  bg = loadImage("woods.jpg");
  bg.resize(1600,900);
  avt = loadImage("Archer_Run_0.png");
  boss1 = loadImage("Boss_0.png");
  enemy = loadImage("Demon.png");
  health = loadImage("Health_0.png");
  fireball = loadImage("Fireball.png");
    
  shoot = minim.loadFile(SHOOT);
  hurt = minim.loadFile(HURT);
  pack = minim.loadFile(HEALTH);
  fire = minim.loadFile(FIREBALL);
  
  won = minim.loadFile(WINS);
  lost = minim.loadFile(LOSES);
  amb = minim.loadFile(AMB);
  
  L1 = new Level_1();
  loadPlayerFrames();
  player = new Player(new PVector(100, 0), avt); 
  amb.loop();
}

//method that switches between states
void draw(){
  println(player.vel.y);
  switch(state){
    case START :
      startScreen();
    break;
    case STORY :
      storyScreen();
    break;
    case LEVEL_ONE : 
      game1();
      //b1.drawMe();
    break;
    case LEVEL_TWO :
      game2();
    break;
    case LEVEL_THREE : 
      game3();
    break;
    case LEVEL_FOUR :
      gameBoss();
    break;
    case WIN :
      winScreen();
    break;
    case LOSE :
      loseScreen();
    break;
  }
}
