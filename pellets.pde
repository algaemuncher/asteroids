class Bullet extends gameObject {

  int timer;

  Bullet() {
    super(player.loc.copy(), player.dir.copy(), 1);
    //loc = new PVector(player.loc.x,player.loc.y);
    //velo = player.dir.copy();
    velo.setMag(10.5);
    timer = 50;
    d=5;
    glowC = color(255, 0, 0);
    strokeW = 2.5;
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
  }
}
