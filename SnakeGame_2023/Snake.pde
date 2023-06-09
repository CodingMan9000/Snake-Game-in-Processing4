class Snake {

  GameScreen screen;

  ArrayList<PVector> segments = new ArrayList<PVector>(); // All the segments of the snake
  PVector pos; // Position of the head
  PVector vel; // Velocity of the snake or direction in wich its moving
  int len = 5; // Initial length of the snake
  boolean dead = false;
  int outlinesize = 3;

  Apple apple;

  Snake(int x, int y, GameScreen screen) {

    this.screen = screen;
    pos = new PVector(x, y);
    vel = new PVector(1, 0);
    apple = new Apple(screen, this);

    grow(len);
  }

  void setDir(int dir) {

    PVector newVel = new PVector();

    switch(dir) {


    case UP:
      newVel.set(0, -1);
      break;
    case DOWN:
      newVel.set(0, 1);
      break;
    case LEFT:
      newVel.set(-1, 0);
      break;
    case RIGHT:
      newVel.set(1, 0);
      break;
    }

    // we check if the new velocity is not opposite of current velocity
    // so that it cant move into its self
    vel = newVel.mult(-1).equals(vel) ? vel : newVel.mult(-1);
  }

  void move() {

    pos.add(vel);

    // We add a new segment to the snake every frame
    segments.add(0, pos.copy());

    // if we eat then we do nothing
    // else we remove the last segment
    if (eat()) {
      apple.updateLocation();
    } else {
      int last = segments.size() - 1;
      segments.remove(last);
    }

    checkTail();
    checkBorder();
  }

  boolean eat() {
    return apple.pos.equals(pos);
  }

  void grow(int size) {
    for (int i = 0; i < size; i++) {
      move();
      segments.add(pos);
    }
  }

  void checkTail() {
    for (int i = 1; i < segments.size(); i++) {
      if (pos.equals(segments.get(i))) dead = true;
    }
  }

  void checkBorder() {
    if (pos.x >= screen.cols || pos.x < 0 || pos.y >= screen.rows || pos.y < 0) dead = true;
  }

  int size() {
    return segments.size() - len;
  }


  void display(int grid_size) {

    fill(255);
    noStroke();

    // Draws the head
    rect(pos.x * grid_size + outlinesize, pos.y * grid_size + outlinesize, grid_size - outlinesize, grid_size - outlinesize);
    PVector p = new PVector((pos.x + segments.get(1).x) * (grid_size / 2), (pos.y + segments.get(1).y) * (grid_size / 2));
    rect(p.x * grid_size + outlinesize, p.y * grid_size + outlinesize, grid_size - outlinesize, grid_size - outlinesize);

    // Draws the rest of the body
    for (int i = 0; i < segments.size() - 1; i++) {

      float x = ((segments.get(i).x + segments.get(i + 1).x) / 2) * grid_size;
      float y = ((segments.get(i).y + segments.get(i + 1).y) / 2) * grid_size;

      rect(x + outlinesize, y + outlinesize, grid_size - outlinesize, grid_size - outlinesize);
      rect(segments.get(i).x * grid_size + outlinesize, segments.get(i).y * grid_size + outlinesize, grid_size - outlinesize, grid_size - outlinesize);
    }

    apple.display(grid_size, outlinesize);
    strokeWeight(1);
  }
}
