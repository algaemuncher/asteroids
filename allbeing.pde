class gameObject {
  PVector loc;
  PVector velo;
  float t=2;
  int lives; //should be in each constructor
  float d; //should be in each constructor
  float strokeW; //should be in each constructor
  color glowC; //should be in each constructor

  gameObject(float lx, float ly, float vx, float vy) {
    loc = new PVector(lx, ly);
    velo = new PVector(vx, vy);
    lives = 1;
  }

  gameObject(PVector l, PVector v, int lv) {
    loc = l;
    velo = v;
    lives = lv;
  }

  void show() {
  }

  void act() {
  }

  void objectShape(float opacity, float strokesize) {
  }

  void warp() {
    if (loc.x+shake.x < -d) loc.x = width+d+shake.x;
    if (loc.x+shake.x > width+d) loc.x = -d-shake.x;
    if (loc.y+shake.y < -d) loc.y = height+d+shake.y;
    if (loc.y+shake.y > height+d) loc.y = -d-shake.y;
  }

  void glow() {
    glowC = color(90, 234, 233);

    //default glow is cyan

    if (this instanceof ufo) { //set glow color
      glowC = color(51, 255, 58);
    } else if (this instanceof particle){
      glowC = color(random(200,255),random(150),0);
    }

    for (int i =0; i<5; i++) {
      pushMatrix();

      if (this instanceof Asteroid || this instanceof Bullet || this instanceof ufo || this instanceof evilBullet) {
        if (this instanceof evilBullet) {
          glowC = color(51, 255, 58);
        }
        translate(loc.x+velo.x, loc.y+velo.y); //glow effect for objects with velocity
      } else {
        translate(loc.x, loc.y); //glow effect for nonmoving objects
      }

      if (this instanceof Spaceship && player.invincibility > 0) {
        objectShape(map(i, 0, 5, 125, 5), strokeW+(i*2.5));
      } else if (this instanceof particle){
        objectShape(map(i, 0, 5, 125, 5), strokeW+(i*1));
      } else {
        objectShape(map(i, 0, 5, 125, 5), strokeW+(i*2.5)); //object stroke -> 5x object stroke
      }
      popMatrix();
    }
  }
}
