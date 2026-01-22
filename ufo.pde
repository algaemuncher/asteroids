class ufo extends gameObject {

  ufo(float X, float Y, float vx, float vy) {
    super(X, Y, vx, vy);
    glowC=color(51, 255, 58);
    strokeW = 2;
    d=45;
    lives = 1;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    objectShape(255, strokeW);
    popMatrix();
  }

  void objectShape(float opacity, float strokesize) {
    noFill();
    stroke(glowC, opacity);
    strokeWeight(strokesize);
    ellipse(0, 15, 40, 15);
    arc(0, 0, 18, 18, radians(145), radians(395));
    circle(0, 0, 2);
    line(0, -12, 0, -20);
    //rect(0,0,50,50);
  }

  void act() {
    loc.add(velo);
    warp();
    collision();
    shoot();
    velo.limit(2);
  }

  void collision() {
    for (int i =0; i<objects.size(); i++) {
      gameObject obj = objects.get(i);
      if (obj instanceof Bullet||obj instanceof rocket) {
        if (dist(obj.loc.x, obj.loc.y, loc.x + 18.5, loc.y)< 21.5 || dist(obj.loc.x, obj.loc.y, loc.x - 18.5, loc.y)< 21.5 || dist(obj.loc.x, obj.loc.y, loc.x, loc.y)<18) {
          shake = velo.copy();
          shake.x *= 3;
          shake.y *= 3;
          shakemax = 16;

          //ufo count
          ufo_total -= 1;

          //damaged
          glowC = color(255, 0, 0);
          obj.glowC = color(255, 0, 0);
          obj.lives = obj.lives - 1;
          lives = 0;
        }
      } else if (obj instanceof Spaceship && player.invincibility == 0) {
        if (dist(obj.loc.x, obj.loc.y, loc.x + 18.5, loc.y)< 21.5 || dist(obj.loc.x, obj.loc.y, loc.x - 18.5, loc.y)< 21.5 || dist(obj.loc.x, obj.loc.y, loc.x, loc.y)<18) {
          shake = velo.copy();
          shake.x *= 3;
          shake.y *= 3;
          shakemax = 16;

          //ufo count
          ufo_total -= 1;

          //damaged
          glowC = color(255, 0, 0);
          obj.glowC = color(255, 0, 0);
          obj.lives = obj.lives - 1;
          lives = 0;
          player.invincibility = 100;
        }
      }
    }
  }
  void shoot() {
    if (frameCount % 30 == 0) {
      objects.add(new evilBullet(loc.x, loc.y));
    }
  }
}
