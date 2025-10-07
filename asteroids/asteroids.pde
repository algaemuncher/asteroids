int mode;
final int INTRO = 0;
final int GAME = 1;
final int GAME_OVER = 2;
final int PAUSE = 3;

PVector loc;
PVector velo;


void setup(){
  size(600,600);
  background(0);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
  
  mode = GAME;
}

void draw(){
  if (mode == INTRO){
    intro();
  } else if (mose == GAME){
    game();
  } else if (mode == GAME_OVER){
    game_over();
  } else if (mode == PAUSE){
    pause();
  }
  
}
