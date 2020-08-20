

class Brain {
  Snake snake;
  Eyes eyes;
  String currentDirection;
  
  int[] neurons = {24, 16, 6, 4}; //24, 16, 6, 4
  NeuralNetwork net;
  
  Brain(Snake snake, boolean randStart) {
    this.snake = snake;
    //println("Braiiiinns");
    this.currentDirection = "right"; 
    this.eyes = snake.eyes;
    net = new NeuralNetwork(this.neurons, this, randStart);
  }
  
  void decideDirection() {
    
    //println("decide");
    //println(this.eyes);
    this.move(this.net.think(this.eyes.inverseDistances()));
  }
  
  
  void inheritBrainFromSnake(Snake snake) {
    this.net.copyFromNetConfig(snake.brain.net);
  }
  
  void crossOverFromSnake(Snake snake){
    this.net.crossOverFromNet(snake.brain.net); //error
  }
  
  void mutateBrain(float mutationRate) {
    this.net.mutateNet(mutationRate);
  }
  
  
  void move(int dir) {
    
    if (dir == 2) {
      if (this.currentDirection != "down") {
        this.snake.movementDirection.x = 0;
        this.snake.movementDirection.y = -1;
        this.currentDirection = "up";
      }
    }
    
    if (dir == 3) {
      if (this.currentDirection != "up") {
        this.snake.movementDirection.x = 0;;
        this.snake.movementDirection.y = 1;
        this.currentDirection = "down";
      }
    }
    
    if (dir == 1) {
      if (this.currentDirection != "left") {
        this.snake.movementDirection.x = 1;
        this.snake.movementDirection.y = 0;
        this.currentDirection = "right";
      }
    }
    
    if (dir == 0) {
      if (this.currentDirection != "right") {
        this.snake.movementDirection.x = -1;
        this.snake.movementDirection.y = 0;
        this.currentDirection = "left";
      }
    }
    
  }
  
  
  void move(String dir) {
    
    if (dir == "up") {
      if (this.currentDirection != "down") {
        this.snake.movementDirection.x = 0;
        this.snake.movementDirection.y = -1;
        this.currentDirection = "up";
      }
    }
    
    if (dir == "down") {
      if (this.currentDirection != "up") {
        this.snake.movementDirection.x = 0;;
        this.snake.movementDirection.y = 1;
        this.currentDirection = "down";
      }
    }
    
    if (dir == "right") {
      if (this.currentDirection != "left") {
        this.snake.movementDirection.x = 1;
        this.snake.movementDirection.y = 0;
        this.currentDirection = "right";
      }
    }
    
    if (dir == "left") {
      if (this.currentDirection != "right") {
        this.snake.movementDirection.x = -1;
        this.snake.movementDirection.y = 0;
        this.currentDirection = "left";
      }
    }
    
  }
  
}
