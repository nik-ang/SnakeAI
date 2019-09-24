
class Matrix {

  int rows;
  int cols;
  float[][] matrix;


  //------------------------------------------------------------------------------
  // MATRIX CONSTRUCTOR
  //------------------------------------------------------------------------------


  //CONSTRUCT MATRIX WITH VALUES AT 0
  Matrix(int i, int j) {
    this.rows = i;
    this.cols = j;
    this.matrix = new float[i][j];
    //println("Rows " + this. rows + " " + "Cols " + this.cols);
    //this.printMatrix(this.matrix);
  }


  //CONSTRUCT MATRIX WITH RANDOMLY INITIALISED VALUES
  Matrix(int i, int j, boolean random) {
    this.rows = i;
    this.cols = j;
    this.matrix = new float[i][j];

    if (random) {
      this.randomInit(-1, 1);
    }

    //this.printMatrix(this.matrix);
  }


  void randomInit(float max, float min) {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.matrix[i][j] = random(max, min);
      }
    }
  }

  //--------------------------------------------------------------------------------------
  void set(int i, int j, float value) {
    this.matrix[i][j] = value;
  }

  //---------------------------------------------------------------------------------------
  // MATRIX OPERATIONS AND FUNCTIONS
  //---------------------------------------------------------------------------------------

  Matrix dot(Matrix m) {
    if (this.cols == m.rows) {
      Matrix result = new Matrix(this.rows, m.cols);

      for (int i = 0; i < this.rows; i++) {
        for (int j = 0; j < m.cols; j++) {
          float sum = 0;
          for (int k = 0; k < this.cols; k++) {
            sum += this.matrix[i][k] * m.matrix[k][j];
          }
          result.matrix[i][j] = sum;
        }
      }

      return result;
    } else {
      throw new NullPointerException("Can't multiply matrices");
    }
  }

  //-----------------------------------------------------------------------------------------------

  Matrix add(Matrix m) {
    if (this.rows == m.rows && this.cols == m.cols) {
      Matrix result = new Matrix(this.rows, this.cols);

      for (int i = 0; i < this.rows; i++) {
        for (int j = 0; j < this.cols; j++) {
          result.matrix[i][j] = this.matrix[i][j] + m.matrix[i][j];
        }
      }
      return result;
    } else {
      throw new NullPointerException("Can't add matrices");
    }
  }
  
  //-----------------------------------------------------------------------------------------------
  
  Matrix squareComponents() {
    Matrix result = new Matrix(this.rows, this.cols);

    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        result.matrix[i][j] *= result.matrix[i][j];
      }
    }
    return result;
    
  }
  
  
  //-----------------------------------------------------------------------------------------------

  Matrix sigmoid() {
    Matrix result = new Matrix(this.rows, this.cols);

    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        result.matrix[i][j] = 1 / (1 + exp(-this.matrix[i][j]));
      }
    }
    return result;
  }
  
  //-----------------------------------------------------------------------------------------------
  
  Matrix relu() {
    Matrix result = new Matrix(this.rows, this.cols);

    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        result.matrix[i][j] = max(0, this.matrix[i][j]);
      }
    }
    return result;
  }
  

  //------------------------------------------------------------------------------
  // GENETIC ALGORITHM METHODS
  //------------------------------------------------------------------------------
  
  
  void mutateMatrix(float mutationRate) {
    
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        float random = random(1);
        if (random < mutationRate) {
          this.matrix[i][j] += randomGaussian()/5;
          
          /*if (this.matrix[i][j] > 1) {
             this.matrix[i][j] = 1;
          }
          
          if (this.matrix[i][j] < -1) {
            this.matrix[i][j] = -1;  
          }*/
          
        }
      }
    }
    
  }
  

  //--------------------------------------------------------------------------------

  Matrix cloneMatrix(Matrix mat) {
    Matrix newMat = new Matrix(mat.rows, mat.cols);

    for (int i = 0; i < mat.rows; i++) {
      for (int j = 0; j < mat.cols; j++) {
        newMat.matrix[i][j] = mat.matrix[i][j];
      }
    }

    return newMat;
  }

  //-----------------------------------------------------------------------------------

  Matrix cloneMatrix() {
    Matrix newMat = new Matrix(this.rows, this.cols);

    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        newMat.matrix[i][j] = this.matrix[i][j];
      }
    }

    return newMat;
  }

  //-------------------------------------------------------------------------------

  void crossOver(Matrix mat) {
    if (this.rows == mat.rows && this.cols == mat.cols) {
      int rowIndex = floor(random(this.rows));
      int colsIndex = floor(random(this.rows));

      for (int i = 0; i < this.rows; i++) {
        for (int j = 0; j < this.cols; j++) {
          if (i < rowIndex || (i == rowIndex && j <= colsIndex)) {
            this.matrix[i][j] = mat.matrix[i][j];
          }
        }
      }
    } else {
      throw new NullPointerException("Can't CrossOver Matrices with different dimensions");
    }
  }


  //-----------------------------------------------------------------------

  void printMatrix(float[][] mat) {
    for (int row = 0; row < mat.length; row++) {
      for (int col = 0; col < mat[row].length; col++) {
        print(mat[row][col]);
      }
      println();
    }
  }
}
