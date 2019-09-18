
class Environment {
  
  PVector origin = new PVector();
  float w;
  float h;
  ArrayList<Snake> snakes = new ArrayList<Snake>();
  int initLength;
  int squareSize;
  float fitnessSum;
  
  Environment(float w, float h, Snake snake) {
    this.w = w;
    this.h = h;
    snakes.add(snake);
  }
  
  Environment(float w, float h, float originX, float originY, int snakesCount, int initLength, int squareSize) {
    this.w = w;
    this.h = h;
    this.origin.x = originX;
    this.origin.y = originY;
    this.initLength = initLength;
    this.squareSize = squareSize;
    for (int i = 0; i < snakesCount; i++) {
      this.snakes.add(new Snake(initLength, squareSize, this));
    }
    
  }
  
  void display() {
    
    fill(0);
    rect(this.origin.x, this.origin.y, this.w, this.h);
    
    for (int i = 0; i < this.snakes.size(); i++) {
      if (!this.snakes.get(i).dead) {
        this.snakes.get(i).display();  
      }
    }     
  }
  
  boolean allSnakesDead() {
    for (int i = 0; i < this.snakes.size(); i++) {
      if (!this.snakes.get(i).dead) {
        return false;
      }
    }
    return true;
  }
  
  
  //Clone
  void getNewGeneration() {
    ArrayList<Snake> newSnakes = new ArrayList<Snake>();
    float runningSum = 0;
    
    float rand = random(runningSum);
    for (int i = 0; i < this.snakes.size(); i++) {
      runningSum += this.snakes.get(i).fitness;
      if (runningSum > rand) {
        newSnakes.add(this.snakes.get(i));
      }
    }
    
  }
  
  void update() {
    
    fill(0);
    stroke(255);
    rect(this.origin.x, this.origin.y, this.w, this.h);
    
    for (int i = 0; i < this.snakes.size(); i++) {
      if (!this.snakes.get(i).dead) {
        this.snakes.get(i).update();  
      }
    }
    
    
    
  }
  
  void calculateFitness() {
    for (int i = 0; i < this.snakes.size(); i++) {
      this.snakes.get(i).calculateFitness();     
    }
    this.fitnessSum = this.calculateFitnessSum();
  }
  
  float calculateFitnessSum() {
    float sum = 0;
    for (int i = 0; i < this.snakes.size(); i++) {
     sum += this.snakes.get(i).fitness; 
    }
    return sum;
  }
  
}
