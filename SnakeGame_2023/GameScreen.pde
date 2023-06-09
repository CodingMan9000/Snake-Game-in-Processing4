class GameScreen extends Screen {

  // This is the main game screen, everything happening in the game is here.

  int cols;
  int rows;
  int grid_size = 20;

  int hud_space = 2;

  String time;
  int startTime;

  Snake snake;

  // ==========================================================================================================
  GameScreen() {
    super();

    cols = width / grid_size;
    rows = (height / grid_size) - hud_space;

    snake = new Snake(0, rows/2, this);

    startTime = millis();
  }

  // ==========================================================================================================
  void update() {
    if (snake.dead) return;
    snake.move();
  }

  // ==========================================================================================================
  void render() {
    background(0);
    drawGrid();
    displayHUD();

    if (snake.dead) return;
    snake.display(grid_size);
  }

  // ==========================================================================================================
  void onResize() {
    cols = width / grid_size;
    rows = (height / grid_size) - hud_space;
  }

  // ==========================================================================================================
  void drawGrid() {
    stroke(25);
    for (int x = 0; x < cols; x++) {
      line(x * grid_size, 0, x * grid_size, height);
    }
    for (int y = 0; y < rows; y++) {
      line(0, y * grid_size, width, y * grid_size);
    }
  }

  // ==========================================================================================================
  void displayHUD() {
    fill(35);
    noStroke();
    rect(0, rows * grid_size, width, height);


    fill(255);
    textFont(tahoma_bold);
    textSize(26 * displayDensity());
    int padding = floor(hud_space * grid_size * 0.5f);

    // Displays the score
    textAlign(LEFT, CENTER);
    text("SCORE: " + snake.size(), 25, (rows * grid_size) + padding);

    if (!snake.dead) {
      int seconds = (millis() - startTime) / 1000;
      int minutes = seconds / 60;
      time = minutes > 0 ? minutes + "m " + seconds % 60 + "s" : seconds + "s";
    }

    // Displays the time
    textAlign(RIGHT, CENTER);
    text("Time : " + time, width - 25, (rows * grid_size) + padding);

    if (!snake.dead) return;

    fill(255);
    textFont(tahoma_bold);
    textAlign(CENTER, CENTER);

    // Game over text
    textSize(46 * displayDensity());
    text("GAME OVER!", width/2, height/2);

    textSize(26 * displayDensity());
    text("[PRESS SPACE]", width/2, height/2 + 46);
  }

  // ==========================================================================================================
  void reset() {
    snake = new Snake(0, rows/2, this);
    startTime = millis();
  }

  // ==========================================================================================================
  void keypress() {

    switch(key) {

    case 'w':
      snake.setDir(UP);
      break;

    case 'a':
      snake.setDir(LEFT);
      break;

    case 's':
      snake.setDir(DOWN);
      break;

    case 'd':
      snake.setDir(RIGHT);
      break;
    }

    if (snake.dead && key == ' ') reset();
  }
}
