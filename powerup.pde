class powerup extends gameObject {
  float x;
  float y;
  int powerup;
  final int gravity=4;
  final int speed=1;
  final int shotgun=2;
  final int rockets =3;

  powerup(float exe, float why) {
    super(exe, why, 0, 0);
    x = exe;
    y = why;
    lives = 1;
    d=12;
    strokeW=2;
    glowC = color(255, 0, 255);
    powerup=int(random(1, 4));
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    objectShape(255, strokeW);
    popMatrix();
  }

  void objectShape(float opacity, float strokesize) {
    noFill();
    strokeWeight(strokesize);
    stroke(glowC, opacity);
    rect(0, 0, d*2, d*2);
    circle(0, 0, d*0.75);
  }

  void act() {
    collision();
  }

  void collision() {
    for (int i = 0; i < objects.size(); i++) {
      gameObject obj = objects.get(i);
      if (obj instanceof Spaceship&&dist(loc.x, loc.y, obj.loc.x, obj.loc.y) < d + obj.d/2) {
        if (powerup == speed) {
          player.powerup = speed;
        } else if (powerup == shotgun) {
          player.powerup = shotgun;
        } else if (powerup == gravity) {
          float x = random(0, width);
          float y = random(0, height);
          objects.add(new gravdisplay(x, y, 500, random(100, 300)));

          i+=1;
        } else if (powerup == rockets) {
          player.powerup = rockets;
        }
        player.powercooldown=200;
        lives=0;
      }
    }
  }
}
class gravdisplay extends gameObject {
  PVector dir;
  float duration;

  gravdisplay(float x, float y, float dura, float diameter) {
    super(x, y, 0, 0);
    glowC = color(155, 78, 222);
    strokeW = 2;
    lives = 1;
    d=diameter;
    dir = new PVector(0, 0);
    duration = dura;
  }

  void show() {
    if (frameCount%10==0) {
      pushMatrix();
      translate(loc.x, loc.y);
      objectShape(75, 0.5);
      popMatrix();
    }
  }

  void act() {
    for (int i = 0; i < objects.size(); i++) {
      gameObject obj = objects.get(i);
      if (dist(loc.x, loc.y, obj.loc.x, obj.loc.y) < d/2 + obj.d/2) {
        PVector dir = PVector.sub(obj.loc, loc);
        dir.div(map(dist(obj.loc.x, obj.loc.y, loc.x, loc.y), d/2, 0, -175, -80));
        obj.velo.add(dir);
      }
    }
    if (duration<=0) {
      lives = 0;
    }
    duration-=1;
  }

  void objectShape(float opacity, float strokesize) {
    fill(glowC, opacity);
    stroke(glowC, opacity);
    strokeWeight(strokesize);
    circle(0, 0, d);
  }
}
