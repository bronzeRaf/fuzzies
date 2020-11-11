% Brouzos Rafael
% mprouzos@auth.gr
% 
% This function makes the forward prediction of the Data "set", evaluating
% the fuzzy interference system "fis". It makes a 200x16 output for 200 t
% values and for 16 time steps (6) forward every time. Max forward time is
% last prediction for t+96.
% Uncomment/comment out needed parts to get the plots of the systems.
% 
% INPUTS:   set    -> The training dataset for the chaotic series anfis
%           fis    -> Fuzzy interference system to be used
%           
% OUTPUTS:  predFW -> 200 sets of 16 forward prediction for max t+96 
% 
% Run the function to check the anfis systems. To  get the set and the fis
% in your Workspace run "prepareData.m" and "makeSC.m" file functions 
% 
% This function suits to the "prepareData.m" and "makeSC.m" scripts. 
% Keep all files together to use the training script.
% 
function predFW = forwardPred(set, fis)
    % Initiliaze 
    predFW = zeros(10,16);
    % Predict normally
    pred = evalfis(set(:,1:3),fis);  % Get prediction for a set
    
    for t=1:200     % loop for t
        predFW(t,1) = pred(1);
        predFW(t,2) = evalfis([set(t,2) set(t,3) predFW(t,1)],fis);
        predFW(t,3) = evalfis([set(t,3) predFW(t,1) predFW(t,2)],fis);
        for i=4:16  % loop for forward predictions
            % Make the prediction
            predFW(t,i) = evalfis([predFW(t,i-3) predFW(t,i-2) predFW(t,i-1)],fis);
        end
    end
end