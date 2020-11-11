# fuzzies
A collection of fuzzy logic projects in MATLAB.

## BloodPressure
This project contains a function, that simulates a Fuzzy Logic Controller, that controls the blood pressure of a patient during a surgery, to maintain his anesthesia on the desired level. The controller is based on a PI controller that works in the Fuzzy Logic domain. The controller obtains the error feedback between the desired pressure and the measured one and the integral of the error feedback. It then calculates the percentage of the medicine as an output. The input domain is divided into Negative Small (NS), Zero (ZE) and Positive Small (PS). The output domain is divided into Zero (ZE), Positive Small (PS), Positive Medium (PM) and Positive Big (PB). The decision is based on empirical rules provided by the medical domain, presented in the following table:

![Empirical rules of the output based on inputs](https://github.com/bronzeRaf/fuzzies/blob/main/bloodPressure/resources/rules.PNG)

#### To run the project features use the following...
- To obtain the Fuzzy Logic Controller and the crisp output run:
``` [flc, y] = BloodPressureflc(x1, x2); ```
	- flc = the Fuzzy Logic Controller
	- y = row vector of the output (crisp) values
	- x1 = row vector of the error of the desired pressure
	- x2 = row vector of the integral of the error

## SatellPI
This project contains a set of functions and scripts that are able to control a satellite. There are both a linear PI controller and a Fuzzy Logic PI controller, created with MATLAB and Simulink. The controller obtains the error feedback and the integral of the error feedback. It then calculates the output. The input and the output domain are divided into Negative Large (NL), Negative Medium (NM), Negative Small (NS), Zero (ZR), Positive Small (PS), Positive Medium (PM) and Positive Large (PL). The decision is based on empirical rules provided by the satellite navigation domain, presented in the following table:

![Empirical rules of the output based on inputs](https://github.com/bronzeRaf/fuzzies/blob/main/satellPI/resources/rules.PNG)

#### To run the project features use the following...
- You can obtain the closed loop transfer function "g" and its "poles" in your workspace after running the code of the "SatellitePI.m" script.

- The file "model.slx" contains the Simulink system of the controller simulation. You can obtain the Fuzzy Logic controller using:
	``` flc = createFLC(); ```
	- flc = the Fuzzy Logic Controller

- You can run the Fuzzy Logic Controller using:
``` y = runFzPI(e, De, KI, KP, KE, flc, T)```
	- e = the error feedback
	- De =  the integral of the error feedback
	- KI = the integral gain
	- KE = the proportional gain
	- flc = the Fuzzy Logic Controller
	- T = the variable of integration


## fuzzycar
This project contains a set of functions and scripts that are able to control an obstacle avoidance navigation of an automotive car. There is both a linear PI controller and a Fuzzy Logic PI controller, created with MATLAB. The controller obtains the angle to the X axis (Theta), the horizontal distance to the obstacle (Dh) and the vertical distance to the obstacle (Dv). It then calculates the theta diversion as an output. The theta domain as long as the output are divided into Negative (N), Zero (ZE) and Positive (P). The distances dh and dv are divided into Small (S), Medium (M) and Large (L). The decision is based on empirical rules provided by the human logic, presented in the following tables, one for each theta division:

![Empirical rules of the output based on inputs](https://github.com/bronzeRaf/fuzzies/blob/main/fuzzycar/resources/rules1.PNG)
![Empirical rules of the output based on inputs](https://github.com/bronzeRaf/fuzzies/blob/main/fuzzycar/resources/rules2.PNG)
![Empirical rules of the output based on inputs](https://github.com/bronzeRaf/fuzzies/blob/main/fuzzycar/resources/rules3.PNG)


#### To run the project features use the following...
- You can obtain the closed loop transfer function "g" and its "poles" in your workspace after running the code of the "simulateCar.m" script.

- You can obtain the Fuzzy Logic controller using:
	``` flc = carController(); ```
	- flc = the Fuzzy Logic Controller


## fuzzyNN
This project contains a set of functions that are able to train and evaluate fuzzy interference systems to forward predict a chaotic series. Quite a few systems have been implemented in this library to be used and compare in several application. There are both 0 and 1 order systems trained by both through backpropagation and the hybrid method. A chaotic timeseries is given as an example in the "resources" folder with unpredictable behavior to apply a tough test to the systems in forward predictions. The functions are able to provide the learning curves and the prediction errors, by uncommenting the lines that the comments mention. The project also provides a function for preprocessing the data and a function for making the forward predictions.

#### To run the project features use the following...
- You can preprocess the data using:
	``` [dataset, valueset, checkset, testset] = prepareData(path, old1, old2, old3, p); ```
	- dataset = the training dataset for the chaotic series anfis
	- valueset = the validation set used during training for the chaotic series anfis
	- checkset = the check set for the chaotic series anfis
	- testset = the test set for the chaotic series anfis
	- path = the full path to the MATLAB saved workspace with the values of the Mackey-Glass differential equation
	- old1 = number of samples backward for the first attribute
	- old2 = number of samples backward for the second attribute
	- old3 = number of samples backward for the third attribute
	- p = number of samples forward for the class value

- You can train the  0 or 1 order fuzzy interference systems with hybrid or backpropagation method using:
	``` [fnnBP0,fnnHB0, fnnBP1, fnnHB1] = createFNN(dataset, valueset, checkset); ```
	- fnnBP0 = 0 order fuzzy neural network using backpropagation
	- fnnHB0 = 0 order fuzzy neural network using hybrid method
	- fnnBP1 = 1 order fuzzy neural network using backpropagation
	- fnnHB1 = 1 order fuzzy neural network using hybrid method
	- dataset = the training dataset for the chaotic series anfis
	- valueset = the validation set used during training for the chaotic series anfis
	- checkset = the check set for the chaotic series anfis

- You can train the 1 order fuzzy interference systems with hybrid method initialized with Grid Partitioning using:
	``` [fnn1, fnn2] = makeTSKhb(dataset, valueset, checkset); ```
	- fnn1 = 1 order fuzzy neural network using hybrid method trained with least MSE on the dataset
	- fnn2 = 1 order fuzzy neural network using hybrid method trained with least MSE on the valueset
	- dataset = the training dataset for the chaotic series anfis
	- valueset = the validation set used during training for the chaotic series anfis
	- checkset = the check set for the chaotic series anfis

- You can train the 1 order fuzzy interference systems with hybrid method initialized with Substractive Clustering using:
	``` [fnn1, fnn2] = makeSC(dataset, valueset, checkset); ```
	- fnn1 = 1 order fuzzy neural network using hybrid method trained with least MSE on the dataset
	- fnn2 = 1 order fuzzy neural network using hybrid method trained with least MSE on the valueset
	- dataset = the training dataset for the chaotic series anfis
	- valueset = the validation set used during training for the chaotic series anfis
	- checkset = the check set for the chaotic series anfis

- You can make forward prediction on data, evaluating the fuzzy interference system using:
	``` predFW = forwardPred(set, fis); ```
	- predFW = 200 sets of 16 forward prediction for data
	- set = the data for the prediction
	- fis = the fuzzy interference system to be used
	
