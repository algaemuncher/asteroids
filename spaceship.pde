class Spaceship extends gameObject {
  PVector dir;
  int bulletcooldown;
  int teleportcooldown;
  int powercooldown;
  int invincibility;
  int powerup=0;
  final int nothing=0;
  final int speed=1;
  final int shotgun=2;
  final int rockets = 3;

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
    if (powercooldown>0) {
      powercooldown--;
    } else if (powercooldown<=0){
      powerup = nothing;
    }
    if (teleportcooldown>0) {
      teleportcooldown--;
    }
    if (invincibility>0) {
      invincibility--;
    }
    if (spaceKey && bulletcooldown <= 0&& powerup != shotgun && powerup != rockets) {
      objects.add(new Bullet());
      bulletcooldown = 15;
      glowC = color(245, 245, 66);
    } else if (spaceKey && bulletcooldown <= 0&&powerup==shotgun) {
      objects.add(new Bullet());
      objects.add(new Bullet(player.loc.x, player.loc.y, player.dir.heading()+0.5));
      objects.add(new Bullet(player.loc.x, player.loc.y, player.dir.heading()-0.5));
      bulletcooldown = 15;
      glowC = color(245, 245, 66);
    } else if (spaceKey && bulletcooldown <= 0&&powerup==rockets) {
      glowC = color(252, 140, 3);
      objects.add(new rocket());
      bulletcooldown = 45;
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
    if (powerup!=speed) {
      velo.limit(5);
    } else if (powerup==speed) {
      velo.limit(10);
    }

    if (leftKey) dir.rotate(-PI/24);
    if (rightKey) dir.rotate(PI/24);
    if (upKey) {
      if (mode!=speed) {
        velo.add(dir);
      } else if (mode==speed) {
        velo.add(dir);
        velo.mult(1.1);
      }
      objects.add(new particle(loc.x-2*velo.x, loc.y-2*velo.y));
    }
    if (downKey) velo.mult(0.85);
  }
}
