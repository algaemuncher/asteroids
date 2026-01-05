class Spaceship extends gameObject {
  PVector dir;
  int bulletcooldown;
  int teleportcooldown;
  int invincibility;

  Spaceship() {
    super(width/2, height/2, 0, 0);
    //loc = new PVector(width/2, height/2);
    //velo = new PVector(0, 0);
    dir = new PVector(0, 1);
    bulletcooldown = 0;
    teleportcooldown = 0;
    invincibility = 0;
    d=20;
    lives = 3;
    strokeW = 2.5;
    glowC = color(245, 245, 66);
  }

  void show() {
    bulletcooldown--;
    if (teleportcooldown>0) {
      teleportcooldown--;
    }
    if (invincibility>0) {
      invincibility--;
    }
    if (spaceKey && bulletcooldown <= 0) {
      objects.add(new Bullet());
      bulletcooldown = 15;
      glowC = color(245, 245, 66);
    }

    if (teleportKey && teleportcooldown <= 0) {
      loc.x = random(0, width);
      loc.y = random(0, height);
      for (int i = 0; i<objects.size(); i++) {
        gameObject obj = objects.get(i);
        if (obj instanceof Asteroid ||obj instanceof ufo) {
          while (dist(loc.x, loc.y, obj.loc.x, obj.loc.y)<150) {
            loc.x = random(0, width);
            loc.y = random(0, height);
          }
        }
      }
      teleportcooldown = 300;
    }
    pushMatrix();
    translate(loc.x, loc.y);
    fill(255, 0, 0);
    textSize(18);
    text("0", 50, 0);
    text("90", 0, 50);
    text("180", -50, 0);
    text("270", 0, -50);
    rect(0, -40, map(teleportcooldown, 0, 300, 0, 40), 10);
    fill(255, 255, 0);
    rect(0, 50, map(invincibility, 0, 100, 0, 40), 10);
    objectShape(255, strokeW);
    popMatrix();
  }

  void objectShape(float opacity, float strokesize) {
    rotate(dir.heading());
    noFill();
    stroke(glowC, opacity);
    strokeWeight(strokesize);
    triangle(-10, -10, -10, 10, 20, 0);
    //circle(0, 0, 50);
  }

  void perform() {
    loc.add(velo);
    velo.limit(5);

    if (leftKey) dir.rotate(-PI/24);
    if (rightKey) dir.rotate(PI/24);
    if (upKey) {
      velo.add(dir);
      objects.add(new particle(loc.x-2*velo.x,loc.y-2*velo.y));
    }
    if (downKey) velo.mult(0.85);
  }
}
