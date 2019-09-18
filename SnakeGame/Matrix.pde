
class Matrix {
  
  int rows;
  int cols;
  float[][] matrix;
  
  
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
    
    this.printMatrix(this.matrix);
    
  }
  
  void set(int i, int j, float value) {
    this.matrix[i][j] = value;  
  }
  
  Matrix dot(Matrix m) {
    if (this.cols == m.rows) {
      Matrix result = new Matrix(this.rows, m.cols);
      
      for (int i = 0; i < this.rows; i++) {
        for (int j = 0; j < m.cols; j++){
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
  
  Matrix sigmoid() {
    Matrix result = new Matrix(this.rows, this.cols);
    
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        result.matrix[i][j] = 1 / (1 + exp(-this.matrix[i][j]));  
      }
    }
    return result;
  }
  
  void randomInit(float max, float min) {
     for (int i = 0; i < this.rows; i++){
       for (int j = 0; j < this.cols; j++) {
         this.matrix[i][j] = random(max, min);
       }
     }
    
  }
  
  void mutateMatrix(float mutationRate) {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.matrix[i][j] *= (1 + mutationRate);  
      }
    }
  }
  
  Matrix cloneMatrix(Matrix mat) {
   Matrix newMat = new Matrix(mat.rows, mat.cols);
   
   for (int i = 0; i < mat.rows; i++) {
     for (int j = 0; j < mat.cols; j++) {
       newMat.matrix[i][j] = mat.matrix[i][j];   
     }
   }
   
   return newMat;
  }
  
  Matrix cloneMatrix() {
   Matrix newMat = new Matrix(this.rows, this.cols);
   
   for (int i = 0; i < this.rows; i++) {
     for (int j = 0; j < this.cols; j++) {
       newMat.matrix[i][j] = this.matrix[i][j];   
     }
   }
   
   return newMat;
  }
  
  void printMatrix(float[][] mat) {
    for (int row = 0; row < mat.length; row++) {
          for (int col = 0; col < mat[row].length; col++) {
              print(mat[row][col]);
          }
          println();
      }
  }
  
}
