class Asteroid extends gameObject {

  float dir=0;
  Asteroid() {
    super(1, 1, 1, 1);
    velo.setMag(random(1, 3));
    velo.rotate(random(TWO_PI));
    lives = 3;
    d= lives*25;
    strokeW=2;
    glowC = color(255);
  }

  Asteroid(float x, float y, int l) {
    super(x, y, 1, 1);
    velo.setMag(random(1, 3));
    velo.rotate(random(TWO_PI));
    lives = l;
    d= lives*25;
    strokeW=2;
    glowC = color(255);
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(dir);
    objectShape(255, strokeW);
    popMatrix();
  }

  void objectShape(float opacity, float strokesize) {
    fill(0);
    stroke(glowC, opacity);
    strokeWeight(strokesize);
    circle(0, 0, d*2);
    line(0, 0, d, 0);
    line(0, 0, d*cos(2*PI/3), d*sin(2*PI/3));
    line(0, 0, d*cos(4*PI/3), d*sin(4*PI/3));
  }

  void act() {
    loc.add(velo);
    warp();
    collision();
    dir+=0.010;
  }

  void collision() {
    for (int i = 0; i < objects.size(); i++) {
      gameObject obj = objects.get(i);
      if (obj instanceof Bullet) {
        if (dist(loc.x, loc.y, obj.loc.x, obj.loc.y) < d + obj.d/2) {
          objects.add(new Asteroid(loc.x, loc.y, lives-1));
          objects.add(new Asteroid(loc.x, loc.y, lives-1));
          //shake setup
          shake = obj.velo.copy();
          shake.x *= 2*lives;
          shake.y *= 2*lives;
          shakemax = 16;

          //asteroid count
          if (d == 75) {
            asteroids_total -= 1;
          }

          //particles
          for (int j = 0; j<15; j++) {
            objects.add(new particle(loc.x-2*velo.x, loc.y-2*velo.y));
          }

          //damaged
          glowC = color(255, 0, 0);
          obj.glowC = color(255, 0, 0);
          obj.lives = obj.lives - 1;
          lives = 0;
        }
      } else if (obj instanceof Spaceship && player.invincibility == 0) {
        if (dist(loc.x, loc.y, obj.loc.x, obj.loc.y) < d + obj.d/2) {
          objects.add(new Asteroid(loc.x, loc.y, lives-1));
          objects.add(new Asteroid(loc.x, loc.y, lives-1));
          //shake setup
          shake = obj.velo.copy();
          shake.x *= 2*lives;
          shake.y *= 2*lives;
          shakemax = 16;

          //particles
          for (int j = 0; j<15; j++) {
            objects.add(new particle(loc.x-2*velo.x, loc.y-2*velo.y));
          }

          //asteroid count
          if (d==75) {
            asteroids_total-=1;
          }

          //damaged
          glowC = color(255, 0, 0);
          obj.glowC = color(255, 0, 0);
          obj.lives = obj.lives - 1;
          lives = 0;
          player.invincibility=100;
        }
      }
    }
  }
}
