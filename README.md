# Genetic-ANFIS-Classification
- Genetic Fuzzy and Genetic ANFIS Classification

<div align="justify">

- Okay, what about combining evolutionary algorithms with fuzzy logic and ANFIS for classification? Well, let’s push some limits!!! Data is consisted of 50 samples with 5 features and 5 classes. You can put your data in the system and run it. You have to play with parameters depending on your data and system. Right now, you can just run the code and see the result. You have to wait for Genetic Algorithm to finish training.

</div>

- Enjoy the code and feel free to ask your question from me:
- Email: mosavi.a.i.buali@gmail.com
- Seyed Muhammad Hossein Mousavi
- CODING IS LOVE - Stay safe and be happy :)
  
![Genetic ANFIS Classification](https://user-images.githubusercontent.com/11339420/148290421-8a23fd8c-c65d-482d-91a8-d600e89b7733.JPG)

# Genetic ANFIS Classification with Fuzzy Logic

This repository provides a MATLAB implementation of a Genetic Adaptive Neuro-Fuzzy Inference System (ANFIS) for classification tasks. The system leverages Fuzzy Logic, Genetic Algorithms (GA), and ANFIS to classify data effectively, demonstrating enhanced accuracy through evolutionary optimization techniques.

---

## Features

- **Fuzzy Logic System Creation**: Automatic generation of a fuzzy inference system (FIS) using clustering techniques.
- **ANFIS Training**: Training a FIS using the ANFIS algorithm to optimize fuzzy rules and parameters.
- **Genetic Algorithm Integration**: Using Genetic Algorithms to fine-tune the FIS and ANFIS parameters.
- **Visualization Tools**: Plotting results, membership functions, and performance metrics for analysis.
- **Performance Metrics**: Includes RMSE, MSE, and confusion matrix for model evaluation.

---

## Files and Descriptions

### Core Functions

1. **[FISCost.m](FISCost.m)**: Calculates the Root Mean Squared Error (RMSE) of a fuzzy inference system (FIS) using the training data.
2. **[FISCreation.m](FISCreation.m)**: Creates an initial FIS using clustering-based Sugeno fuzzy modeling.
3. **[FISParameters.m](FISParameters.m)**: Extracts and organizes parameters of a FIS.
4. **[FISSet.m](FISSet.m)**: Updates the FIS parameters with new values.

### Training and Optimization

5. **[ANFISTrain.m](ANFISTrain.m)**: Trains a FIS using the ANFIS algorithm with customizable training options.
6. **[GeneticTrain.m](GeneticTrain.m)**: Implements the Genetic Algorithm for optimizing FIS parameters.

### Visualization

7. **[PlotVisual.m](PlotVisual.m)**: Plots target vs. output results with performance metrics such as MSE and RMSE.

### Support Functions

8. **[RouletteWS.m](RouletteWS.m)**: Implements a roulette wheel selection mechanism for GA.
9. **[evolve.mat](evolve.mat)**: Example dataset for training and testing the models.

