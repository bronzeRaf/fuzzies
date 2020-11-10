# fuzzies
A collection of fuzzy logic projects in MATLAB.

## BloodPressure
This project contains a function, that simulates a Fuzzy Logic Controller, that controls the blood pressure of a patient during a surgery, to maintain his anesthesia on the desired level. The controller is based on a PI controller that works in the Fuzzy Logic domain. The controller obtains the error feedback between the desired pressure and the measured one and the integral of the error feedback. It then calculates the percentage of the medicine as an output. The input domain is divide into Negative Small (NS), Zero (ZE) and Positive Small (PS). The output domain is divided into Zero (ZE), Positive Small (PS), Positive Medium (PM) and Positive Big (PB). The decision is based on empirical rules provided by the medical domain, presented in the following table:

![Empirical rules of the output based on inputs](https://github.com/bronzeRaf/fuzzies/blob/main/bloodPressure/resources/rules.PNG)

#### To run the project features use the following...
- To obtain the Fuzzy Logic Controller and the crisp output run:
``` [flc, y] = BloodPressureflc(x1, x2); ```
	- flc = the Fuzzy Logic Controller
	- y = row vector of the output (crisp) output values
	- x1 = row vector of the error of the desired pressure
	- x2 = row vector of input values
