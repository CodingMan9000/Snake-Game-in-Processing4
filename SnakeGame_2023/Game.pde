class Game {

  // The this a straight up copy of game from LibGDX,
  // But yeah basically it hold the current screen

  Screen screen;

  Game() {
    
  }

  void setScreen(Screen screen) {
    this.screen = screen;
  }

  void update() {
    screen.update();
  }

  void render() {
    screen.render();
  }

  void onResize() {
    screen.onResize();
  }

  void keypress() {
    screen.keypress();
  }

  void mousepress() {
    screen.mousepress();
  }
}
