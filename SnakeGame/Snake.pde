
class Snake {
  
  ArrayList<SnakeSquare> snakeParts = new ArrayList<SnakeSquare>();
  
  int snakeLength;
  int timesFed = 0;
  float score = 0;
  float squareSize;
  PVector movementDirection = new PVector();
  boolean dead = false;
  int movesLeft = 400; //ARBITRARY
  int survivalTime = 0;
  float fitness = 0;
  
  
  SnakeSquare head;
  Brain brain;
  Eyes eyes;
  Environment environment;
  Food food;
  
//--------------------------------------------------------------------------------------------  
// CONSTRUCTOR  
// -------------------------------------------------------------------------------------------

  Snake(int initialLength, float squareSize, Environment environment, boolean randStart) {
    //println("I am a snake");
    this.snakeLength = initialLength;
    this.squareSize = squareSize;
    
    
    this.environment = environment;
    this.movementDirection.x = 0;
    this.movementDirection.y = -1;
    
    this.eyes = new Eyes(this);
    this.brain = new Brain(this, randStart);
    
    //float originX = environment.origin.x + floor(random(100, environment.w - 100) / squareSize) * squareSize;
    //float originY = environment.origin.y + floor(random(100, environment.h - 100) / squareSize) * squareSize;
   
    float originX = (environment.origin.x + environment.w)/2;
    float originY = (environment.origin.y + environment.h)/2;
    
    for (int i = 0; i < initialLength; i++) {
      this.snakeParts.add(new SnakeSquare(originX , originY + i*squareSize, squareSize, this)); 
    }
    this.head = this.snakeParts.get(0);
    
    this.food = new Food(this);
    
  }
  
//----------------------------------- 
  
  void update() {
    
    if (this.outOfBounds(this.head.position) || this.movesLeft == 0) {
      this.dead = true;
    }
    
    if (this.canFeed()) {
      this.eat(); 
    }
    
    if (this.crashedTail()) {
      this.dead = true; 
    }
    
    if (!this.dead) {
      this.eyes.lookAtDirections();
      this.brain.decideDirection();
      this.move();
    }
    //this.display();
         
  }
  
//----------------------------------
  
  void move() {
    
    PVector direction = this.movementDirection.copy();
    direction.mult(this.squareSize);
    
    //println(direction);
    //println(this.head.position);
    
    float previousX = this.snakeParts.get(0).position.x;
    float previousY = this.snakeParts.get(0).position.y;
    
    this.head.position.add(direction);
    for (int i = 1; i < this.snakeParts.size(); i++) {
      float currentX = this.snakeParts.get(i).position.x;
      float currentY = this.snakeParts.get(i).position.y;
      this.snakeParts.get(i).move(previousX, previousY);
      previousX = currentX;
      previousY = currentY;
    }
    
    this.movesLeft--;
    this.survivalTime++;

    //println("Moved");
    //this.display();
    
  }
  
//-------------------------------------------  
  
  boolean outOfBounds(PVector position) {
    if (position.x < this.environment.origin.x || position.x >= this.environment.w + this.environment.origin.x || position.y < this.environment.origin.y || position.y >= this.environment.h + this.environment.origin.y) {
      return true;
    } else {
      return false;
    }
  }
  
//--------------------------------------------

  boolean crashedTail() {
    for (int i = 1; i < this.snakeParts.size(); i++) {
      if (this.snakeParts.get(i).position.equals(this.head.position)) {
        return true;
      }
    }
    return false;
  }

//--------------------------------------------  
  boolean canFeed() {
    if (this.head.position.equals(this.food.position)) {
      return true;
    }
    return false;
  }
  
  
//-----------------------------------------------

  void eat() {
    this.snakeLength++;
    this.timesFed++;
    this.score = this.timesFed * this.movesLeft;
    this.resetMoves(200);
    PVector newSquarePos = this.snakeParts.get(this.snakeParts.size() - 1).position;
    this.snakeParts.add(new SnakeSquare(newSquarePos.x, newSquarePos.y, this.squareSize, this));
    this.food.placeRandom();
  }
  
//-------------------------------------------------- ARBITRARY

  void resetMoves(int moves) {
     this.movesLeft = min(max(moves*this.timesFed, 400), 2000); 
  }
  
  
//------------------------------------------------

  float calculateFitness() {
    float fit = 1 +  (this.score * this.score) * (this.survivalTime * this.survivalTime);
    this.fitness = fit;
    return fit;
  }
  
  
//-------------------------------------------  
  void display() {
    fill(255, 255, 255);
    for (int i = 0; i < this.snakeParts.size(); i++) {
      this.snakeParts.get(i).display();
    }
    this.food.display();
  }
}

//
