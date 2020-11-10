% Brouzos Rafael 7945
% mprouzos@auth.gr
% 
% This function creates a fuzzy inference system to control a Satellite's
% motor. The Fuzzy Interference system has 2 Inputs e and De and one 
% output Y.

% e, De and Y @ [-1,1] as normalized.
% 
% Run the function to get the fis in your Workspace and test it with 
% evalfis.
% 
% This function suits to the Simulink model "model.sxl". Name the fis "flc"
% to your Workspace and use the model.
% 
% For more information on the system check its documentation "reply2.pdf".
function flc = createFLC()
    
    %create the fuzzy logic system with the given parameters
    flc = newfis('SatController');
    %set given parameters
    flc = setfis(flc, 'andmethod', 'min');
    flc = setfis(flc, 'impmethod', 'prod');
    %aggragate method is by default set as max
    %defuzz method  is by default set as centroid
    
    %add the I/O variables
    flc = addvar(flc,'input','E',[-1 1]);
    flc = addvar(flc,'input','DE',[-1 1]);
    flc = addvar(flc,'output','Y',[-1 1]);
    
    %add mf to each variable
    %E and DE space
    step = 1/3;
    c = -1:(1/3):1;     %centers of mf
    for i = 1:2         %add variables' E and DE space partitioning
        flc = addmf(flc,'input',i,'NL','trimf',[c(1)-step c(1) c(1)+step]);
        flc = addmf(flc,'input',i,'NM','trimf',[c(2)-step c(2) c(2)+step]);
        flc = addmf(flc,'input',i,'NS','trimf',[c(3)-step c(3) c(3)+step]);
        flc = addmf(flc,'input',i,'ZE','trimf',[c(4)-step c(4) c(4)+step]);
        flc = addmf(flc,'input',i,'PS','trimf',[c(5)-step c(5) c(5)+step]);
        flc = addmf(flc,'input',i,'PM','trimf',[c(6)-step c(6) c(6)+step]);
        flc = addmf(flc,'input',i,'PL','trimf',[c(7)-step c(7) c(7)+step]);
    end
    
    %Y space
    step = 1/4;
    c = -1:(1/4):1;     %centers of mf
    flc = addmf(flc,'output',1,'NV','trimf',[c(1)-step c(1) c(1)+step]);
    flc = addmf(flc,'output',1,'NL','trimf',[c(2)-step c(2) c(2)+step]);
    flc = addmf(flc,'output',1,'NM','trimf',[c(3)-step c(3) c(3)+step]);
    flc = addmf(flc,'output',1,'NS','trimf',[c(4)-step c(4) c(4)+step]);
    flc = addmf(flc,'output',1,'ZE','trimf',[c(5)-step c(5) c(5)+step]);
    flc = addmf(flc,'output',1,'PS','trimf',[c(6)-step c(6) c(6)+step]);
    flc = addmf(flc,'output',1,'PM','trimf',[c(7)-step c(7) c(7)+step]);
    flc = addmf(flc,'output',1,'PL','trimf',[c(8)-step c(8) c(8)+step]);
    flc = addmf(flc,'output',1,'PV','trimf',[c(9)-step c(9) c(9)+step]);
    
    
    %define the rules loop (metarules for FZ-PI)
    rule=zeros(49,5);
    count = 1;
    for i = 1:7         %E  loop
        for j = 1:7     %DE loop
            if i+j <= 5
                then = 2;   %NL
            elseif i+j == 6
                then = 3;   %MN
            elseif i+j == 7
                then = 4;   %NS
            elseif i+j == 8
                then = 5;   %ZE
            elseif i+j == 9
                then = 6;   %PS
            elseif i+j == 10
                then = 7;   %PM
            else
                then = 8;   %PL
            end
            rule(count,:) = [i j then 1 1];
            count = count+1;
        end
    end
    
    %add the rules to the system
    flc = addrule(flc,rule);
end