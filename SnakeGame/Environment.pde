
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
      this.snakes.add(new Snake(initLength, squareSize, this, true));
    }
    
  }
  
  //---------------------------------------------------------------------------------
  
  void display() {
    
    fill(0);
    rect(this.origin.x, this.origin.y, this.w, this.h);
    
    for (int i = 0; i < this.snakes.size(); i++) {
      if (!this.snakes.get(i).dead) {
        this.snakes.get(i).display();  
      }
    }     
  }
  
  //---------------------------------------------------------------------------------
  
  boolean allSnakesDead() {
    for (int i = 0; i < this.snakes.size(); i++) {
      if (!this.snakes.get(i).dead) {
        return false;
      }
    }
    return true;
  }
  
  //--------------------------------------------------------------------------------
  
  Snake selectParent() {
    float runningSum = 0;
    
    float rand = random(this.fitnessSum);
    for (int i = 0; i < this.snakes.size(); i++) {
      runningSum += this.snakes.get(i).fitness;
      if (runningSum > rand) {
        return this.snakes.get(i);
      }
    }
    
    return null;
  }
  
  Snake[] selectParents() {
    Snake parents[] = new Snake[2];
    ArrayList<Snake> potentialParents = new ArrayList<Snake>(this.snakes);
    float randFather = random(this.fitnessSum);
    float randMother = 0;
    float runningSum = 0;
    
    for (int i = 0; i < this.snakes.size(); i++) {
      runningSum += this.snakes.get(i).fitness;
      if (runningSum > randFather) {
        parents[0] = this.snakes.get(i);
        potentialParents.remove(i);
        randMother = random(this.fitnessSum - this.snakes.get(i).fitness);
        break;
      }
    }
    
    runningSum = 0;
    for (int i = 0; i < potentialParents.size(); i++) {
      runningSum += potentialParents.get(i).fitness;
      if (runningSum > randMother) {
        parents[1] = potentialParents.get(i);
        break;
      }
    }
    
    return parents;
    
  }
  
  //---------------------------------------------------------------------------------
  
  ArrayList<Snake> createNewGeneration(float mutationRate) {

    ArrayList<Snake> newGen = new ArrayList<Snake>();
    
    
    for (int i = 0; i < this.snakes.size(); i++) {
      newGen.add(new Snake(this.initLength, this.squareSize, this, false));
      Snake[] parents = this.selectParents();
      
      newGen.get(i).brain.inheritBrainFromSnake(parents[0]);
      newGen.get(i).brain.crossOverFromSnake(parents[1]);
      newGen.get(i).brain.mutateBrain(mutationRate);
      
    }
    
    return newGen;
    
  }
  
  
  //---------------------------------------------------------------------------------
  
  void update() {
    
    fill(0);
    stroke(255);
    rect(this.origin.x, this.origin.y, this.w, this.h);
    
    for (int i = 0; i < this.snakes.size(); i++) {
      if (!this.snakes.get(i).dead) {
        this.snakes.get(i).update();  
      }
    }
    
    if (this.allSnakesDead()) {
      this.calculateFitness();
      this.calculateFitnessSum();
      this.snakes = this.createNewGeneration(0.05);
    }
       
  }
  
  //---------------------------------------------------------------------------------
  
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
