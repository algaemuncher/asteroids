class evilBullet extends gameObject {
  int timer;
  evilBullet(float X, float Y) {
    super(X, Y, 1, 1);
    velo.set(player.loc.x - loc.x, player.loc.y - loc.y);
    velo.setMag(5);
    timer = 50;
    d=5;
    glowC = color(51, 255, 58);
    strokeW = 2.5;
    lives = 1;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    objectShape(255, strokeW);
    popMatrix();
  }

  void objectShape(float opacity, float strokesize) {
    fill(0);
    stroke(glowC, opacity);
    strokeWeight(strokesize);
    circle(0, 0, d);
  }

  void act() {
    loc.add(velo);
    timer--;
    if (timer == 0) lives = 0;
    collision();
    velo.limit(2);
  }

  void collision() {
    for (int i =0; i<objects.size(); i++) {
      gameObject obj = objects.get(i);
      if (obj instanceof Bullet) {
        if (dist(loc.x, loc.y, obj.loc.x, obj.loc.y) < d + obj.d/2) {
          shake = velo.copy();
          shake.x *= 3;
          shake.y *= 3;
          shakemax = 16;

          //damaged
          glowC = color(255, 0, 0);
          obj.glowC = color(255, 0, 0);
          obj.lives = obj.lives - 1;
          lives = 0;
        }
      } else if (obj instanceof Spaceship && player.invincibility == 0) {
        if (dist(loc.x, loc.y, obj.loc.x, obj.loc.y) < d + obj.d/2) {
          shake = velo.copy();
          shake.x *= 3;
          shake.y *= 3;
          shakemax = 16;

          //damaged
          glowC = color(255, 0, 0);
          obj.glowC = color(255, 0, 0);
          obj.lives = obj.lives - 1;
          lives = 0;
          player.invincibility = 200;
        }
      }
    }
  }
}
