% Brouzos Rafael
% mprouzos@auth.gr
% 
% This function creates a fuzzy inference system to control a Car to reach
% to a target point and deals with the obstacle avoidance
% The Fuzzy Interference system has 3 Inputs dv, dh, theta and one 
% output Dth.

% INPUTS:   dv ->   vertical distance, [0, 1],      3 trianglural mfs
%           dh -> horizontal distance, [0, 1],      3 trianglural mfs
%        theta ->     angle to X axis, [-180, 180], 3 trianglural mfs
% OUTPUTS:  Dth-> Diversion of theta,  [-130, 130], 3 trianglural mfs
% 
% Run the function to get the fis in your Workspace and test it with 
% evalfis.
% 
% This function suits to the "simulateCar.m" navigation simulation script. 
% Keep both files together to use the simulation script.
% 
function flc = carController()
    %create the fuzzy logic system with the given parameters
    flc = newfis('Car controller');
    %set given parameters
    %imp method is by default Mamdani
    %and method is by default set as min
    %aggragate method is by default set as max
    %defuzz method  is by default set as centroid
    
    %add the I/O variables
    flc = addvar(flc,'input','dv',[0 1]);
    flc = addvar(flc,'input','dh',[0 1]);
    flc = addvar(flc,'input','theta',[-180 180]);
    flc = addvar(flc,'output','DTH',[-130 130]);
    
    %add mf to each variable
    %dv
    flc = addmf(flc,'input',1,'S','trimf',[-0.5 0 0.5]);
    flc = addmf(flc,'input',1,'M','trimf',[0 0.5 1]);
    flc = addmf(flc,'input',1,'L','trimf',[0.5 1 1.5]);
    %dh
    flc = addmf(flc,'input',2,'S','trimf',[-0.5 0 0.5]);
    flc = addmf(flc,'input',2,'M','trimf',[0 0.5 1]);
    flc = addmf(flc,'input',2,'L','trimf',[0.5 1 1.5]);
    %theta
    flc = addmf(flc,'input',3,'N','trimf',[-360 -180 0]);
    flc = addmf(flc,'input',3,'ZE','trimf',[-180 0 180]);
    flc = addmf(flc,'input',3,'P','trimf',[0 180 360]);
    %DTH
    flc = addmf(flc,'output',1,'N','trimf',[-260 -130 0]);
    flc = addmf(flc,'output',1,'ZE','trimf',[-130 0 130]);
    flc = addmf(flc,'output',1,'P','trimf',[0 130 260]);

    %define the rules
    rule=zeros(27,6);
    %theta = N
    rule(1,:) = [1 1 1 1 1 1];
    rule(2,:) = [2 1 1 1 1 1];
    rule(3,:) = [3 1 1 2 1 1];
    rule(4,:) = [1 2 1 1 1 1];
    rule(5,:) = [2 2 1 2 1 1];
    rule(6,:) = [3 2 1 3 1 1];
    rule(7,:) = [1 3 1 2 1 1];
    rule(8,:) = [2 3 1 3 1 1];
    rule(9,:) = [3 3 1 3 1 1];
    %theta = ZE
    rule(10,:) = [1 1 2 1 1 1];
    rule(11,:) = [2 1 2 1 1 1];
    rule(12,:) = [3 1 2 1 1 1];
    rule(13,:) = [1 2 2 1 1 1];
    rule(14,:) = [2 2 2 1 1 1];
    rule(15,:) = [3 2 2 1 1 1];
    rule(16,:) = [1 3 2 2 1 1];
    rule(17,:) = [2 3 2 2 1 1];
    rule(18,:) = [3 3 2 3 1 1];
    %theta = P
    rule(19,:) = [1 1 3 1 1 1];
    rule(20,:) = [2 1 3 1 1 1];
    rule(21,:) = [3 1 3 2 1 1];
    rule(22,:) = [1 2 3 1 1 1];
    rule(23,:) = [2 2 3 1 1 1];
    rule(24,:) = [3 2 3 2 1 1];
    rule(25,:) = [1 3 3 1 1 1];
    rule(26,:) = [2 3 3 2 1 1];
    rule(27,:) = [3 3 3 3 1 1];
    
    %add the rules to the system
    flc = addrule(flc,rule);
end