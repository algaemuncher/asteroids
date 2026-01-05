void intro() {
  background(0);
  fill(255, 210);

  frameNum+=1;
  if (frameNum>41) {
    frameNum=0;
  }
  imageMode(CENTER);
  image(here[frameNum], 300, 300);
  
  textSize(100);
  text("asteroids", 300, 150);

  for (int i = 0; i < dashamount; i++) {
    dashes[i].show();
    dashes[i].act();
    dashes[i].glow();
  }
}

class dash extends gameObject {
  int ibX = int(random(width));
  int ibY = int(random(width));
  int p = 0;

  dash() {
    super(random(0, width), random(0, height), 0, 5);
    strokeW = 1;
  }

  void show() {
    objectShape(100, 1);
  }

  void objectShape(float opacity, float strokesize) {
    fill(glowC, opacity);
    rect(loc.x, loc.y, 5, 20);
  }


  void act() {
    loc.add(velo);
    if (loc.y - 10 > height) {
      loc.y = -10;
    }
  }
}
