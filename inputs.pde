void keyPressed() {
  if (keyCode == LEFT) leftKey = true;
  if (keyCode == UP) upKey = true;
  if (keyCode == RIGHT) rightKey = true;
  if (keyCode == DOWN) downKey = true;
  if (key == ' ') spaceKey = true;
  if (key == 't') teleportKey = true;
}

void keyReleased() {
  if (keyCode == LEFT) leftKey = false;
  if (keyCode == UP) upKey = false;
  if (keyCode == RIGHT) rightKey = false;
  if (keyCode == DOWN) downKey = false;
  if (key == ' ') spaceKey = false;
  if (key == 't') teleportKey = false;
}

void mouseReleased() {
  if (mode == INTRO) {
    mode = GAME;
    asteroids_total = 8;
    ufo_total = 3;
    
  } else if (mode == GAME_OVER) {
    mode = GAME;
    objects.clear();
    player = new Spaceship();
    objects.add(player);
    asteroids_total = 8;
    ufo_total = 3;
    
  }
}

float aTriangle(float b, float h) {
  return(b*h)/2;
}
