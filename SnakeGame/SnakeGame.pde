


void setup() {
  size(1000, 600);
  println("Initiate");
  frameRate(15);
  background(0);
  aPlace.update();
}

Environment aPlace = new Environment(900, 500, 20, 20, 20, 3, 10);

void draw() {
  background(0);
  aPlace.update();  
}

void keyTyped() {
  
  if (key == 'w' || key == 'W') {
    aPlace.snakes.get(0).brain.move("up");
  }
  
  if (key == 's' || key == 'S') {
    aPlace.snakes.get(0).brain.move("down");
  }
  
  if (key == 'a' || key == 'A') {
    aPlace.snakes.get(0).brain.move("left");
  }
  
  if (key == 'd' || key == 'D') {
    aPlace.snakes.get(0).brain.move("right");
  }
  
  //println(snak.movementDirection);
  
}
