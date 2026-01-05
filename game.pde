

void game() {
  background(0);

  if (frameCount%500==0 && asteroids_total > 0) {
    float x = random(0, width);
    float y = random(0, height);
    int j=100;
    while (j>0) {
      if (dist(x, y, player.loc.x, player.loc.y)<300) {
        x = random(0, width);
        y = random(0, height);
      }
      j--;
    }
    objects.add(new Asteroid(x, y, 4));
  }

  if (frameCount%600==0 && ufo_total > 0) {
    int r1 = int(random(0, 3));
    int r2=0;
    r1*=300;
    if (r1 == 0) {
      r2=300;
    } else if (r1==1) {
      r2=-40;
    } else if (r1==2) {
      r2=300;
    }

    objects.add(new ufo(r1, r2, cos(radians(r1*90)), sin(radians(r1*90))));
  }

  //noFill();
  //circle(loc.x, loc.y, d);

  //loc.add(velo);
  //velo.add(gravity);

  //player.show();
  //player.perform();

  for (int i = 0; i<objects.size(); i++) {
    pushMatrix();
    translate(shake.x, shake.y); //shake inplement
    gameObject currentObject = objects.get(i);
    currentObject.glow();
    currentObject.act();
    currentObject.show();
    //ufo warp delete
    if (currentObject instanceof ufo) {
      if (currentObject.loc.x+shake.x < -45 || currentObject.loc.x+shake.x > width+45 || currentObject.loc.y+shake.y < -45 || currentObject.loc.y+shake.y > height+45) {
        currentObject.lives = 0;
      }
    }
    currentObject.warp();

    if (currentObject instanceof Spaceship) {
      player.perform(); //different act name
    }
    if (currentObject.lives == 0) {
      shake.set(-shake.x, -shake.y);
      objects.remove(i);
      i-=1;
    }
    //currentObject.perform();
    popMatrix();
  }

  //shake engine
  if (shakemax>0) {
    if (frameCount % 2 ==0) {
      shake.mult(random(-0.5, -0.8));
      shakemax-=1;
    }
  } else {
    shake.mult(0);
  }
  println(shakemax);

  //if (shakemax>0) shakemax-=0.01;

  fill(255, 0, 0);
  textSize(30);
  text("angle: "+ round(player.dir.heading() * 180/PI), 120, 30);

  if (player.lives <1) {
    mode = GAME_OVER;
    objects.clear();
    objects.add(new Asteroid(random(0,width), random(0,height), 1));
    objects.add(new Asteroid(random(0,width), random(0,height), 1));
    objects.add(new Asteroid(random(0,width), random(0,height), 1));
    objects.add(new Asteroid(random(0,width), random(0,height), 1));
    objects.add(new Asteroid(random(0,width), random(0,height), 1));
    wintrigger = false;
  } else if (asteroids_total <= 0 && mapcheck() == true) {
    mode = GAME_OVER;
    objects.clear();
    player = new Spaceship();
    objects.add(player);
    player.lives = 1;
    wintrigger = true;
  }
}

boolean mapcheck(){
  for (int i = 0; i < objects.size(); i++){
    if (objects.get(i) instanceof ufo || objects.get(i) instanceof Asteroid){
      return false;
    }
    
  }
  return true;
}
