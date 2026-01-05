import java.util.ArrayList;
Spaceship player;

//ArrayList<Bullet> bullets;
ArrayList<gameObject> objects;

int mode;
final int INTRO = 0;
final int GAME = 1;
final int GAME_OVER = 2;
final int PAUSE = 3;

PImage[] here;
int frameNum=42;

boolean upKey, downKey, leftKey, rightKey, spaceKey, teleportKey;

PVector loc;
PVector velo;
PVector gravity;
float d;

PVector shake;
float shakemax;
int r=1;

boolean wintrigger;

int dashamount = 100;
dash[] dashes = new dash[dashamount];

int asteroids_total;
int ufo_total;

PFont normal;

//color glowC = color(255);

void setup() {
  normal = createFont("Serif", 85);
  textFont(normal);
  size(600, 600);
  background(0);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  objects = new ArrayList();

  mode = INTRO;
  //wintrigger = true;

  loc = new PVector(width/2, height/2);

  velo = new PVector(5, 0);
  velo.rotate(random(0, 2*PI));
  gravity = new PVector(0, 0.066743);
  d=100;

  player = new Spaceship();
  objects.add(player);

  shake = new PVector(100, 0);

  for (int i = 0; i <dashamount; i++) {
    dashes[i] = new dash();
  }

  here = new PImage[frameNum];
  int i = 0;
  while (i < frameNum) {

    here[i] = loadImage("heret/frame_"+i+".gif");
    here[i].resize(30,30);
    i++;
  }
}

void draw() {
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == GAME_OVER) {
    game_over();
  } else if (mode == PAUSE) {
    pause();
  }
  //grid();
}

void grid() {
  stroke(0, 255, 44);
  strokeWeight(0.5);
  for (int i =1; i<13; i++) {
    line(i*50, 0, i*50, height);
    line(0, i*50, width, i*50);
  }
}
