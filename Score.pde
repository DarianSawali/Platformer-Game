//This class helps hold the score
class Score {
  int score;
  
  Score() {
    score = 0; 
  }
  
  //increases score
  void scoreUpdate(int inc){
    score += inc;  
  }
  
  //draws score
  void drawScore(Character c) {
    fill(255);
    text("SCORE : " + score, c.pos.x, c.pos.y -30);
  }
  
  //gives score
  void giveScore(){
    fill(255);
    text("SCORE : " + score, width/2, height/2 + 70);
  } 
}
