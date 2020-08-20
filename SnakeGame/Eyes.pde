
class Eyes {
  Snake snake;
  SnakeSquare head;
  PVector [] directionsVectors = {
    //Left
    new PVector(-1, 0), 
    //Right
    new PVector(1, 0), 
    //Up
    new PVector(0, -1), 
    //Down
    new PVector(0, 1), 
    //Up Left
    new PVector(-1, -1), 
    //Down Left
    new PVector(-1, 1), 
    //Up right
    new PVector(1, -1), 
    //Down right
    new PVector(1, 1)
  };

  //8 Directions, 3 Things
  // [left, right, up, down, up-left, down-left, up-right, down-right]
  // [Food, Wall, Tail]
  int[][] distances = new int[8][3];

//------------------------------------------------------------------------------
// CONSTRUCTOR
//------------------------------------------------------------------------------

  Eyes(Snake snake) {
    this.snake = snake;

    for (int i = 0; i < this.distances.length; i++) {
      for (int j = 0; j < this.distances[i].length; j++) {
        this.distances[i][j] = 0;
      }
    }
  }

//-------------------------------------------------------------------------------

  void lookAtDirections() {


    for (int v = 0; v < this.directionsVectors.length; v++) {

      int i = 1;
      PVector checkLoc = this.snake.head.position.copy();
      PVector vectorStep = this.directionsVectors[v].copy().mult(this.snake.squareSize);
      checkLoc.add(vectorStep);

      boolean foundFood = false;
      boolean foundWall = false;
      boolean foundTail = false;

      while (!this.snake.outOfBounds(checkLoc)) {
        //ellipse(checkLoc.x, checkLoc.y, 3, 3);

        if (!foundFood) {
          if (this.findFood(checkLoc)) {
            this.distances[v][0] = i;
            foundFood = true;
            //print(v);
            //print(i);
          } else {
            this.distances[v][0] = 0;
          }
        }

        if (!foundWall) {
          if (this.findWall(checkLoc)) {
            this.distances[v][1] = i;
            foundWall = true;
          } else {
            this.distances[v][1] = 0;
          }
        }

        if (!foundTail) {
          if (this.findTail(checkLoc)) {
            this.distances[v][2] = i;
            foundTail = true;

            /*if (v == 0) {
              println(this.distances[v][2]);
            }*/
          } else {
            this.distances[v][2] = 0;
          }
        }

        i++;
        checkLoc.add(vectorStep);
        //println(this.distances[1][1]);
      }
    }
  }

//--------------------------------------------------------------------------------  
  
  float[][] squaredDistances() {
    
    float[][] squaredDistances = new float[this.distances.length][this.distances[0].length];
    
    for (int i = 0; i < this.distances.length; i++) {
      for (int j = 0; j < this.distances[0].length; j++) {
        squaredDistances[i][j] = pow(this.distances[i][j], 2);  
      }
    }
    
    return squaredDistances;
  }
  
 //-------------------------------------------------------------------------------
 
 float[][] inverseDistances() {
    
    float[][] inverseSqr = new float[this.distances.length][this.distances[0].length];
    
    for (int i = 0; i < this.distances.length; i++) {
      for (int j = 0; j < this.distances[0].length; j++) {
        inverseSqr[i][j] = 10 / (this.distances[i][j] + 1);
      }
    }
    
    return inverseSqr;
  }
  
  
  
//--------------------------------------------------------------------------------

  boolean findFood(PVector location) {
    if (this.snake.food.position.equals(location)) {
      return true;
    }
    return false;
  }
  
//--------------------------------------------------------------------------------

  boolean findWall(PVector location) {  
    if (this.outOfBounds(location)) {
      return true;
    }
    return false;
  }

//------------------------------------------------------------------------------

  boolean findTail(PVector location) {
    for (int i = 0; i < this.snake.snakeParts.size(); i++) {
      if (this.snake.snakeParts.get(i).position.equals(location)) {
        return true;
      }
    }
    return false;
  }

//------------------------------------------------------------------------------

  boolean outOfBounds(PVector position) {
    if (position.x < this.snake.environment.origin.x + this.snake.squareSize || position.x + this.snake.squareSize >= this.snake.environment.w + this.snake.environment.origin.x || position.y < this.snake.environment.origin.y + this.snake.squareSize || this.snake.squareSize + position.y >= this.snake.environment.h + this.snake.environment.origin.y) {
      return true;
    } else {
      return false;
    }
  }
}
