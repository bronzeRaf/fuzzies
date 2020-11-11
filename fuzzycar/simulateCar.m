% Brouzos Rafael
% mprouzos@auth.gr
% 
% This script simulates the navigation of a automotive car. The script
% plots the navigation and the obstacles of the enviroment. We assume that
% the the enviroment is the standart given one, without dynamic obstacles.
% 
% NOTE!It is required to have the fuzzy logic controller named "flc" in 
% your workspace, as the function from "carController.m" provides. In other 
% case you will miss the fuzzy interference system and the script is
% useless. SO:
% Keep "carController.m" in the same folder as the script and the run the 
% current script. In other case the script could not find the required
% function to get the FIS.
% 
% NOTE! This script CLEARS all the workspace during its initilization. Take
% care of that and keep a backup of your workspace before hiting run.
% 

%clear previous workspace
clear all;

%Set input parameters
%________________________________
%point initial position
curX = 9.1;
curY = -4.3;
theta = 90;
%define velocity in m/s
u = 0.05;
%set maximun converge time
maxTime = 50;
%define sampling time of the FIS in sec
T = 0.2;
%________________________________

%point target
tarX = 15;
tarY = -7.2;

%Functional code starts here
%create FIS required
flc = carController();
%initialize distance to target
eps = sqrt((tarX-curX)^2+(tarY-curY)^2);
curTime = 0;

i = 1;  %count iterations
tic;    %count time to converge
%main navigation loop
while eps > 0.1 && curTime < maxTime
    navigation(i,:) = [curX; curY];
    %Find dh, dv according to current (X,Y) position
    dv = abs(curY);
    if dv < 5
        dh = 10 - curX; %obstacle line 1
    elseif dv < 6
        dh = 11 - curX; %obstacle line 2
    elseif dv < 7
        dh = 12 - curX; %obstacle line 3
    else
        dh = 15;        %big distance for obstacle
    end
    
    %normalize dh, dv to be in [0,1]
    dv = dv/15;
    dh = dh/15;
    %limit dv to 1
    if dv>1 
        dv =1;
    elseif dv<0
        dv =0;
    end
    %limit dh to 1
    if dh>1 
        dh =1; 
    elseif dh<0
        dh = 0;
    end
    %limit theta to [-180, 180]
    if theta <-180
        theta = 360+theta;
    elseif theta > 180
        theta = theta - 360;
    end
    
    %calculate DTH from fuzzy controller
    Dth = evalfis([dv dh theta],flc);
    
    theta = theta + Dth; %apply control
    tt(i)=Dth;
    %calculate current position
    ux = u*cosd(theta); %velocity to X direction
    uy = u*sind(theta); %velocity to Y direction
    curX = curX+ux*T;   %constant velocity
    curY = curY+uy*T;   %constant velocity
    
    %calculate distance to target
    eps = sqrt((tarX-curX)^2+(tarY-curY)^2);
    curTime = toc; %get elapsed time
    i = i+1;
end

%plot the navigation and the obstacles
figure;
%Obstacles
x = [10, 10, 11, 11, 10];
y = [0, 5, 5, 0, 0];
plot(x, -y, 'b-', 'LineWidth', 3);   %obstacle line 1
hold on;
x = [11, 11, 12, 12, 11];
y = [0, 6, 6, 0, 0];
plot(x, -y, 'b-', 'LineWidth', 3);   %obstacle line 2
hold on;
x = [12, 12, 15, 15, 12];
y = [0, 7, 7, 0, 0];
plot(x, -y, 'b-', 'LineWidth', 3);   %obstacle line 3
hold on;
%plot navigation of the car
plot(navigation(:,1), navigation(:,2), 'r-', 'LineWidth', 1);   

elapsedTime = toc; %time of navigation!