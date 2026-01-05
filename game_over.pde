void game_over() {
  background(0);

  if (wintrigger == true) {

    for (int i =0; i<5; i++) {
      pushMatrix();
      fill(200, 0, 0, 220-i*30);
      textSize(80+i*5);
      text("You Won!", 300, 100);
      popMatrix();
    }

    pushMatrix();
    translate(-600, -600);
    scale(3);
    for (int i = 0; i < objects.size(); i++) {
      gameObject obj = objects.get(i);
      if (obj instanceof particle) {
        obj.show();
        obj.act();
        obj.glow();
      }
    }
    objects.add(new particle(320, 300));
    player.dir.set(-10, -2);
    player.glow();

    popMatrix();
  } else if (wintrigger == false) {
    for (int i = 0; i < objects.size(); i++) {
      gameObject obj = objects.get(i);
      if (obj instanceof Asteroid) {
        obj.d = 50;
        obj.show();
        obj.act();
        obj.glow();
      }
    }

    for (int i =0; i<5; i++) {
      pushMatrix();
      fill(200, 0, 0, 220-i*30);
      textSize(80+i*5);
      text("You Lost!", 300, 100);
      popMatrix();
    }
  }

  for (int i =0; i<5; i++) {
    pushMatrix();
    fill(200, 0, 0, 220-i*30);
    textSize(50+i*2);
    text("Press to try again", 300, 500);
    popMatrix();
  }
}
