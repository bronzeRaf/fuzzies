% Brouzos Rafael
% mprouzos@auth.gr
% 
% This function creates a fuzzy inference system to control the Anesthesia
% during a surgery. It receives two parameters and produces one output as: 

% x1: row vector of input values for e (error of the desired pressure).
% x2: row vector of input values for I(e) (Intergrate of the error of the
% desired pressure).
% 
% y: row vector of output values (crisp).
% 
% For more information on the system check its documentation "reply1.pdf".
% 
% Note! For multiple input values use x1, x2 as ROW VECTORS.
% The output values is provided as a ROW VECTOR for each pair of input 
% values.
function [flc, y] = BloodPressureflc(x1, x2)
    
    %create the fuzzy logic system with the given parameters
    flc = newfis('Blood pressure controller');
    %set given parameters
    flc = setfis(flc, 'andmethod', 'prod');
    flc = setfis(flc, 'impmethod', 'prod');
    %aggragate method is by default set as max
    %defuzz method  is by default set as centroid
    
    %add the I/O variables
    flc = addvar(flc,'input','X1',[-5 5]);
    flc = addvar(flc,'input','X2',[-90 90]);
    flc = addvar(flc,'output','Y',[0 3]);
    
    %add mf to each variable
    %X1
    flc = addmf(flc,'input',1,'NS','trimf',[-10 -5 0]);
    flc = addmf(flc,'input',1,'ZE','trimf',[-5 0 5]);
    flc = addmf(flc,'input',1,'PS','trimf',[0 5 10]);
    %X2
    flc = addmf(flc,'input',2,'NS','trimf',[-180 -90 0]);
    flc = addmf(flc,'input',2,'ZE','trimf',[-90 0 90]);
    flc = addmf(flc,'input',2,'PS','trimf',[0 90 180]);
    %Y
    flc = addmf(flc,'output',1,'ZE','trimf',[-1 0 1]);
    flc = addmf(flc,'output',1,'PS','trimf',[0 1 2]);
    flc = addmf(flc,'output',1,'PM','trimf',[1 2 3]);
    flc = addmf(flc,'output',1,'PB','trimf',[2 3 4]);
    
    %define the rules
    rule1 = [1 1 4 1 1];
    rule2 = [1 2 4 1 1];
    rule3 = [1 3 4 1 1];
    rule4 = [2 1 4 1 1];
    rule5 = [2 2 3 1 1];
    rule6 = [2 3 2 1 1];
    rule7 = [3 1 2 1 1];
    rule8 = [3 2 2 1 1];
    rule9 = [3 3 2 1 1];
    %add the rules to the system
    ruleList = [rule1;rule2;rule3;rule4;rule5;rule6;rule7;rule8;rule9;];
    flc = addrule(flc,ruleList);
    
    %finaly get the outpout
    y = evalfis([x1 x2], flc);
    
end