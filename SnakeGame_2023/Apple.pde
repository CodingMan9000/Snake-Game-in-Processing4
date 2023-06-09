class Apple {

  Snake snake;
  PVector pos;

  int cols;
  int rows;

  Apple(GameScreen screen, Snake snake) {
    cols = screen.cols;
    rows = screen.rows;
    this.snake = snake;
    pos = new PVector();
    updateLocation();
  }

  void updateLocation() {

    // Set the position to a random location
    pos.x = floor(random(cols));
    pos.y = floor(random(rows));

    // If it is over the snake then using recurssion
    // we change the loaction until it is a valid cell
    while (snake.segments.contains(pos)) {
      updateLocation();
    }
  }

  void display(int grid_size, int outlinesize) {
    fill(255, 0, 0);
    noStroke();
    rect(pos.x * grid_size + outlinesize, pos.y * grid_size + outlinesize, grid_size - outlinesize, grid_size - outlinesize);
  }
}
