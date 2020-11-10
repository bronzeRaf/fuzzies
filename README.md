# fuzzies
A collection of fuzzy logic projects in MATLAB.

## BloodPressure
This project contains a function, that simulates a Fuzzy Logic Controller, that controls the blood pressure of a patient during a surgery, to maintain his anesthesia on the desired level. The controller is based on a PI controller that works in the Fuzzy Logic domain. The controller obtains the error feedback between the desired pressure and the measured one and the integral of the error feedback. It then calculates the percentage of the medicine as an output. The input domain is divide into Negative Small (NS), Zero (ZE) and Positive Small (PS). The output domain is divided into Zero (ZE), Positive Small (PS), Positive Medium (PM) and Positive Big (PB). The decision is based on empirical rules provided by the medical domain, presented in the following table:

![Empirical rules of the output based on inputs](https://github.com/bronzeRaf/fuzzies/blob/main/bloodPressure/resources/rules.PNG)

#### To run the project features use the following...
- To obtain the Fuzzy Logic Controller and the crisp output run:
``` [flc, y] = BloodPressureflc(x1, x2); ```
	- flc = the Fuzzy Logic Controller
	- y = row vector of the output (crisp) values
	- x1 = row vector of the error of the desired pressure
	- x2 = row vector of the integral of the error

## SatellPI
This project contains a set of functions and scripts that are able to control a satellite. There are both a linear PI controller and a Fuzzy Logic one, created with MATLAB and Simulink.

![Empirical rules of the output based on inputs](https://github.com/bronzeRaf/fuzzies/blob/main/satellPI/resources/rules.PNG)

#### To run the project features use the following...
- You can obtain the closed loop transfer function "g" and its "poles" in your workspace after running the code of the "SatellitePI.m" script.

- The file "model.slx" contains the Simulink system of the controller simulation. You can obtain the Fuzzy Logic controller using:

	``` flc = createFLC(); ```
	- flc = the Fuzzy Logic Controller

- You can run the Fuzzy Logic Controller using:
``` y = runFzPI(e, De, KI, KP, KE, flc, T)```
	- e = 
	- De = 
	- KI =
	- KE = 
	- flc = the Fuzzy Logic Controller
	- T = 


