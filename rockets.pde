class rocket extends gameObject {

  int timer;

  rocket() {
    super(player.loc.copy(), player.dir.copy(), 1);
    //loc = new PVector(player.loc.x,player.loc.y);
    //velo = player.dir.copy();
    velo.setMag(10.5);
    timer = 50;
    d=10;
    glowC = color(252, 140, 3);
    strokeW = 2.5;
    if (player.powerup==player.shotgun) {
      timer = 10;
      velo.setMag(21);
    } else if (player.powerup==player.rockets) {
      velo.setMag(5.5);
      timer = 100;
    }
  }

  rocket(float x, float y, float di) {
    super(x, y, di);

    velo.setMag(10.5);
    timer = 50;
    d=10;
    glowC = color(252, 140, 3);
    strokeW = 2.5;
    if (player.powerup==player.shotgun) {
      timer = 10;
      velo.setMag(21);
    }
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
    rect(0, 0, sqrt(2*(d*d)), sqrt(2*(d*d)));
    circle(0, 0, d);
  }

  void act() {
    loc.add(velo);
    timer--;
    if (timer == 0) lives = 0;
    track();
  }

  void track() {
    for (int i = 0; i < objects.size(); i++) {
      gameObject obj = objects.get(i);
      if (obj instanceof Asteroid|| obj instanceof ufo) {
        if (dist(loc.x,loc.y,obj.loc.x,obj.loc.y)<200) {
          PVector dir = PVector.sub(obj.loc, loc);
          dir.div(100);
          velo.add(dir);
          velo.limit(6);
          break;
        }
      }
    }
  }
}
