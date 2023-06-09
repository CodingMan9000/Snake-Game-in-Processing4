// WARNING: This code has unnecessary code templete

PFont tahoma_bold;

// The game
Game game;

int prevW, prevH;

void setup() {

  size(1200, 720);
  //frameRate(6);
  surface.setResizable(true);
  registerMethod("pre", this);

  prevW = width;
  prevH = height;
  tahoma_bold = loadFont("Tahoma-Bold-48.vlw");

  game = new Game();
  game.setScreen(new GameScreen());
}

void draw() {
  
  // updates and renders the game every 8 frames
  if (frameCount % 8 == 0) {
    game.update();
    game.render();
  }
}

void pre() {

  // Window resize function
  if (prevW != width || prevH != height) {
    game.onResize();
  }
}

void mousePressed() {
  game.mousepress();
}

void keyPressed() {
  game.keypress();
}
