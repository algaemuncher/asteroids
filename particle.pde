class particle extends gameObject {
  int opacity = int(random(150,200));
  float shape = int(random(0, 3));
  float size = random(5);
  particle(float X, float Y) {
    super(X, Y, random(-1, 1), random(-1, 1));
    glowC=color(255, 127, 0);
    lives=1;
    strokeW = map(size,0,5,0,1);
  }

  void show() {
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(opacity);
    objectShape(opacity, 1);
    popMatrix();
  }

  void act() {
    opacity-=4;
    if (opacity<=0) {
      lives = 0;
    }
    loc.add(velo);
  }

  void objectShape(float opac, float strokesize) {
    noFill();
    stroke(glowC, opacity-opac);
    strokeWeight(strokesize);
    if (shape == 0) {
      square(0,0,size);
    } else if (shape == 1) {
      scale(size/2);
      triangle(-1,0,0,sqrt(3),1,0);
    } else if (shape == 2) {
      circle(0,0,size);
    }
  }
}
