% Brouzos Rafael
% mprouzos@auth.gr
% 
% This code creates the closed loop function for the satellite control
% problem. Point in the root locus the desired pole and the program will
% automatically fix your choise, create the closed loop transfer funtion, 
% print the step info and plot the step responce of the system.
% 
% You can check "Ki" and "Kp" gains selected for the PI controller in your
% Workspace after running the code.

% You can check the closed loop transfer function "g" and its "poles" in 
% your Workspace after running the code.
% 
% For more information on the system check its documentation "reply1.pdf".

    %create the open loop transfer function of the plant (without gain)
    h = tf([1 3],[1 10 9]);       % H = (s+3)/(s+1)(s+9)

    %uncoment following lines to check the root locus for k values
    k = 0:0.1:100;
    rlocus(h, k);           %poles in closed loop
    axis([-30 3 -15 15]);   %zoom in
    %set values to fullfil requirements
    zeta = 0.6;     %zeta value < 1
    wn = 1.5;       %natural frequency
    sgrid(zeta,wn); %print 
    [kg, poles] = rlocfind(h);
    %find pid parameters
    Kp = kg/10;
    Ki = 3*Kp;
    lc = pid(Kp,Ki);
    
    %trial and error closed loop step responce
    figure;
    g = feedback(lc*h, 1);  %closed loop transfer function
    step(g);                %step response
    S = stepinfo(g)         %print step info (add semicolon to avoid printing)
    
    
