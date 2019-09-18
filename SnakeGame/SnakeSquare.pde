

class SnakeSquare {
  
  float sideLength;
  PVector position = new PVector();
  Snake snake;
  
  SnakeSquare(float posX, float posY, float sideLength, Snake snake) {
    this.position.x = posX;
    this.position.y = posY;
    this.sideLength = sideLength;
    this.snake = snake;
  }
 
 
  void move(float posX, float posY) {
    this.position.x = posX;
    this.position.y = posY;
  }
 
  void display() {
    rect(this.position.x, this.position.y, this.sideLength, this.sideLength); 
  }
  
}
