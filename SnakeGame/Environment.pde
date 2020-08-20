
class Environment {

  PVector origin = new PVector();
  float w;
  float h;
  ArrayList<Snake> snakes = new ArrayList<Snake>();
  Snake bestSnake;
  int initLength;
  int squareSize;
  float fitnessSum;
  int generation = 1;
  //Train Generations without displaying for better initial performance
  int generationsDisplayless = 0;

  Environment(float w, float h, Snake snake) {
    this.w = w;
    this.h = h;
    snakes.add(snake);
  }

  Environment(float w, float h, float originX, float originY, int snakesCount, int initLength, int squareSize, int generationsDisplayless) {
    this.w = w;
    this.h = h;
    this.origin.x = originX;
    this.origin.y = originY;
    this.initLength = initLength;
    this.squareSize = squareSize;
    this.generation = 0;
    this.generationsDisplayless = generationsDisplayless;
    for (int i = 0; i < snakesCount; i++) {
      this.snakes.add(new Snake(initLength, squareSize, this, true));
    }
    bestSnake = this.snakes.get(0);
  }

  //---------------------------------------------------------------------------------

  // Display Snakes
  void display(boolean displayOnlyBest) {

    fill(0);
    rect(this.origin.x, this.origin.y, this.w, this.h);

    if (displayOnlyBest) {
      this.bestSnake.display();
    } else {
      for (int i = 0; i < this.snakes.size(); i++) {
        if (!this.snakes.get(i).dead) {
          this.snakes.get(i).display();
        }
      }
    }
  }

  //---------------------------------------------------------------------------------
  
  //Check if all Snakes are dead 
  boolean allSnakesDead() {
    for (int i = 0; i < this.snakes.size(); i++) {
      if (!this.snakes.get(i).dead) {
        return false;
      }
    }
    return true;
  }

  //--------------------------------------------------------------------------------

  //Select a pair of parents
  Snake[] selectParents() {
    
    Snake parents[] = new Snake[2];
    //First all Snakes are potential parents
    ArrayList<Snake> potentialParents = new ArrayList<Snake>(this.snakes);
    
    
    //Selectt a value from 0 to the total Fitness sumed by all Snakes
    //[RRRRRRRRRRRRRRRRRRRRRR........................................]
    
    //If the selected snakes's fitness is lower than the randm value, use fitness as base to sum the next fitness
    //[ssssssssRRRRRRRRRRRRRR........................................]
    
    //If the next Sum is highger than the random value, add Snake to Array, if not, keep adding.
    //[sssssssSSSSSSSSSSSSSSSSSSSS...................................]
    
    float fitSum = this.fitnessSum;
    float randFather = random(fitSum);
    float randMother = 0;
    float runningSum = 0;
    

    for (int i = 0; i < this.snakes.size(); i++) {
      runningSum += this.snakes.get(i).fitness;
      if (runningSum > randFather) {
        //Add Snake to Array
        parents[0] = this.snakes.get(i);
        //Remove Father from potential parents
        potentialParents.remove(i);
        //Substract the father's fitness from the FitnessSum to ensure finding a mother
        fitSum -= this.snakes.get(i).fitness;
        break;
      }
    }
    
    //Same Parent Finding Process
    runningSum = 0;
    for (int i = 0; i < potentialParents.size(); i++) {
      randMother = random(fitSum);
      runningSum += potentialParents.get(i).fitness;
      if (runningSum > randMother) {
        parents[1] = potentialParents.get(i);
        break;
      }
    }
    return parents;
  }

  //---------------------------------------------------------------------------------

  //Return a new ArrayList of Snakes with babies from selected parents
  ArrayList<Snake> createNewGeneration(float mutationRate) {

    ArrayList<Snake> newGen = new ArrayList<Snake>();
    
    //Clone last generation's best snake's genes just in case population gets worse.
    newGen.add(new Snake(this.initLength, this.squareSize, this, false));
    newGen.get(0).brain.inheritBrainFromSnake(this.bestSnake);
    this.bestSnake = newGen.get(0);
    
    //Breed and mutate the rest
    for (int i = 1; i < this.snakes.size(); i++) {
      newGen.add(new Snake(this.initLength, this.squareSize, this, false));
      Snake[] parents = this.selectParents();

      //Copy genes from father
      newGen.get(i).brain.inheritBrainFromSnake(parents[0]);
      //Copy genes from mother starting at a random point at the brain
      newGen.get(i).brain.crossOverFromSnake(parents[1]);
      //Mutate slightly
      newGen.get(i).brain.mutateBrain(mutationRate);
    }

    return newGen;
  }

  //---------------------------------------------------------------------------------
 

  //---------------------------------------------------------------------------------

  //Update state of the game
  void update() {
    
    //Clear all screen.
    fill(0);
    stroke(255);
    rect(this.origin.x, this.origin.y, this.w, this.h);

    //Update living snakes
    for (int i = 0; i < this.snakes.size(); i++) {
      if (!this.snakes.get(i).dead) {
        this.snakes.get(i).update();
      }
    }
    
    //Clear if all snakes are dead and proceed to create new generation
    if (this.allSnakesDead()) {
      this.calculateFitness();
      this.calculateFitnessSum();
      this.snakes = this.createNewGeneration(0.1);
      this.generation++;
    }
    
    //Display the snakes
    if (generation > generationsDisplayless) this.display(true);
  }

  //---------------------------------------------------------------------------------

  void calculateFitness() {
    for (int i = 0; i < this.snakes.size(); i++) {
      this.snakes.get(i).calculateFitness();
    }
    this.fitnessSum = this.calculateFitnessSum();
    this.selectBestSnake();
  }

  //---------------------------------------------------------------------------------

  float calculateFitnessSum() {
    float sum = 0;
    for (int i = 0; i < this.snakes.size(); i++) {
      sum += this.snakes.get(i).fitness;
    }
    
    return sum;
  }

  //---------------------------------------------------------------------------------

  void selectBestSnake() {
    Snake best = this.snakes.get(0);
    for (int i = 1; i < this.snakes.size(); i++) { 
      if (this.snakes.get(i).fitness > best.fitness) {
        best = this.snakes.get(i);
      }
    }

    this.bestSnake = best;
  }
}
