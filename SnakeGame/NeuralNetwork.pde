
class NeuralNetwork {

  Brain brain;

  Matrix[] layersAct;
  Matrix[] layersWeights;
  Matrix[] layersBiases;

  int[] neuronsQty;

  //---------------------------------------------------------------------------------------------------------------------
  // CONSTRUCTOR
  //--------------------------------------------------------------------------------------------------------------------- 


  //Construct the Network with an array of integers which represent the amount of neurons in every layer.  
  NeuralNetwork(int[] lays, Brain brain, boolean randStart) {
    //NeuralNetwork ({3, 2, 1})

    this.brain = brain;

    //Activations, Weights and Biases are stored in arrays of matrices, in which the index act as layer
    //LayersActs acts as the layers of neurons
    this.layersAct = new Matrix[lays.length];

    //For the L layers of neurons in layerAct, there are L - 1 weights and biases associated with them. Therefore, the index of both layerWeights and layerBiases is layerAct.length - 1
    this.layersWeights = new Matrix[lays.length - 1];
    this.layersBiases = new Matrix[lays.length - 1];

    //Store the amount of neurons in each layer, which comes from the constructor itself
    this.neuronsQty = lays;

    //INITIALISE MATRICES IN ARRAYS

    //Activations are stored in column vectors 
    for (int i = 0; i < layersAct.length; i++) {
      //println("ACTIVATIONS");
      layersAct[i] = new Matrix(lays[i], 1);
    }

    //Weights are stored in N x K matrices, where N is the amount of neurons in its corresponding layer, and K is the amount of neurons in the previous layer
    //Any layer of neurons L contains its weights and biases in the layer L - 1 of both layerWeights and layerBiases
    for (int i = 0; i < layersWeights.length; i++) {
      //println("WEIGHTS");
      layersWeights[i] = new Matrix(lays[i + 1], lays[i], randStart);
    }

    //Biases are stored in column vectors
    //Any layer of neurons L contains its weights and biases in the layer L - 1 of both layerWeights and layerBiases
    for (int i = 0; i < layersBiases.length; i++) {
      //println("BIASES");
      layersBiases[i] = new Matrix(lays[i + 1], 1, randStart);
    }
  }
  
  
  //---------------------------------------------------------------------------------------------------------------------
  // GENERIC NETWORK METHODS
  //---------------------------------------------------------------------------------------------------------------------  

  //Fill the Input Layer with a 2D array
  //The amount of input neurons has to match the dimensions of the 2d array
  void feedInfo(float[][] infoMatrix) {

    if (infoMatrix.length * infoMatrix[0].length == this.neuronsQty[0]) {
      //print("feed info");
      int k = 0;
      for (int i = 0; i < infoMatrix.length; i++) {
        for (int j = 0; j < infoMatrix[0].length; j++) {
          this.layersAct[0].matrix[k][0] = infoMatrix[i][j];
          k++;
        }
      }
    } else {
      throw new NullPointerException("Neurons don't match the information");
    }
  }

  //Fill the Input Layer with a 2D array
  //The amount of input neurons has to match the dimensions of the 2d array
  void feedInfo(int[][] infoMatrix) {
    if (infoMatrix.length * infoMatrix[0].length == this.neuronsQty[0]) {
      int k = 0;
      for (int i = 0; i < infoMatrix.length; i++) {
        for (int j = 0; j < infoMatrix[0].length; j++) {
          this.layersAct[0].matrix[k][0] = infoMatrix[i][j];
          k++;
        }
      }

      //this.layersAct[0].printMatrix(layersAct[0].matrix);
    } else {
      throw new NullPointerException("Neurons don't match the information");
    }
  }

  //For every layer of activation, starting with the first non-input layer, the activations are calculated by the dot product of its Weights . Activations of previous Layer
  //Biases are then added, then values are squishified
  void feedForward() {
    for (int i = 1; i < this.layersAct.length; i++) {
      this.layersAct[i] = this.layersWeights[i - 1].dot(this.layersAct[i - 1]).add(this.layersBiases[i - 1]).relu();
      //this.layersAct[i].printMatrix(this.layersAct[i].matrix);
    }
  }

  //Outputs index of neuron with higher activation
  int output() {
    Matrix outputLayer = this.layersAct[this.neuronsQty.length - 1];
    int index = 0;
    float highest = 0;
    for (int i = 0; i < outputLayer.matrix.length; i++) {
      if (outputLayer.matrix[i][0] > highest) {
        highest = outputLayer.matrix[i][0];
        index = i;
      }
    }
    return index;
  }

  //---------------------------------------------------------------------------------------------------------------------
  // GENETIC ALGORITHM METHODS
  //---------------------------------------------------------------------------------------------------------------------    

  void copyFromNetConfig(NeuralNetwork net) {
    for (int i = 0; i < this.layersAct.length; i++) {
      this.layersAct[i] = net.layersAct[i].cloneMatrix();  
    }
    for (int i = 0; i < this.layersWeights.length; i++) {
      this.layersWeights[i] = net.layersWeights[i].cloneMatrix();  
    }
    for (int i = 0; i < this.layersBiases.length; i++) {
      this.layersBiases[i] = net.layersBiases[i].cloneMatrix();  
    }
    
  }
  
  void crossOverFromNet(NeuralNetwork net) {
    for (int i = 0; i < this.layersAct.length; i++) {
      this.layersAct[i].crossOver(net.layersAct[i]);  
    }
    for (int i = 0; i < this.layersWeights.length; i++) {
      this.layersWeights[i].crossOver(net.layersWeights[i]);
    }
    for (int i = 0; i < this.layersBiases.length; i++) {
      this.layersBiases[i].crossOver(net.layersBiases[i]);
    }
    
  }

  void mutateNet(float mutationRate) {
    for (int i = 0; i < this.layersWeights.length; i++) {
      this.layersWeights[i].mutateMatrix(mutationRate);
    }
  }

  //---------------------------------------------------------------------------------------------------------------------
  // SNAKE-SPECIFIC METHODS
  //---------------------------------------------------------------------------------------------------------------------

  int think(float[][] infoMatrix) {
    this.feedInfo(infoMatrix);
    this.feedForward();

    return this.output();
  }

  int think(int[][] infoMatrix) {
    //println("Think");
    this.feedInfo(infoMatrix);
    this.feedForward();


    return this.output();
  }
}
