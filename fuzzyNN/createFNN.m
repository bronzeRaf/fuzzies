% Brouzos Rafael
% mprouzos@auth.gr
% 
% This function prepares 4 fuzzy interference systems. The training set
% is the given and the systems are both 0 and 1 order with both methods
% backpropagation and hybrid.
% Uncomment/comment out needed parts to get the plots of the systems.
% 
% INPUTS:   dataset -> The training dataset for the chaotic series anfis
%           valueset-> The validation set for the chaotic series anfis
%           checkset-> The check set for the chaotic series anfis
% 
% OUTPUTS:  fnnBP0 -> 0 order fuzzy neural network using backpropagation
%           fnnHB0 -> 0 order fuzzy neural network using hybrid method
%           fnnBP1 -> 1 order fuzzy neural network using backpropagation
%           fnnHB1 -> 1 order fuzzy neural network using hybrid method
% 
% Run the function to train the anfis systems. To  get the dataset in your 
% Workspace run "prepareData.m" file function
% 
% This function suits to the "prepareData.m" dataset script. 
% Keep both files together to use the training script.
% 

function [fnnBP0,fnnHB0, fnnBP1, fnnHB1] = createFNN(dataset, valueset, checkset)
    %initialize options with default values
    trnOpt = [65 0 0.01 0.9 1.1];
    dispOpt = [1 1 1 1];

    % ZERO ORDER SYSTEM
    % Initalize the fuzzy interference system
    initfnn = genfis1(dataset, 2, 'gbellmf','constant');
    
    % Train fis with backpropagation method
    % fnnBP is the anfis with the minimun checking error
    [trnFis, trnError, stepsize, fnnBP0, ErrorBP0] = ...
        anfis(dataset, initfnn, trnOpt, dispOpt, valueset, 0);
    % Uncomment to plot Predictions and error curves
    % Plot predictions for DATASET
%     pred = evalfis(dataset(:,1:3),fnnBP0);  %Get prediction for a set
%     plotForMe(dataset, pred, 'fnnBP0 Data set Predictions');
%     % Plot predictions for VALUESET
%     clear pred;
%     pred = evalfis(valueset(:,1:3),fnnBP0);  %Get prediction for a set
%     plotForMe(valueset, pred, 'fnnBP0 Value set Predictions');
%     % Plot predictions for CHECKSET
%     pred = evalfis(checkset(:,1:3),fnnBP0); %Get prediction for a set
%     plotForMe(checkset, pred, 'fnnBP0 Test set Predictions');
%     
    
    % Train fis with hybrid method
    % fnnHB is the anfis with the minimun checking error
    [trnFis, trnError, stepsize, fnnHB0, ErrorHB0] = ...
        anfis(dataset, initfnn, trnOpt, dispOpt, valueset, 1);
    % Uncomment to plot Predictions and error curves
    % Plot predictions for DATASET
%     pred = evalfis(dataset(:,1:3),fnnHB0);  %Get prediction for a set
%     plotForMe(dataset, pred, 'fnnHB0 Data set Predictions');
%     % Plot predictions for VALUESET
%     pred = evalfis(valueset(:,1:3),fnnHB0);  %Get prediction for a set
%     plotForMe(valueset, pred, 'fnnHB0 Value set Predictions');
%     % Plot predictions for CHECKSET
%     pred = evalfis(checkset(:,1:3),fnnHB0); %Get prediction for a set
%     plotForMe(checkset, pred, 'fnnHB0 Test set Predictions');
%     
    
    % FIRST ORDER SYSTEM
    % Initalize the fuzzy interference system
    initfnn = genfis1(dataset, 2, 'gbellmf','linear');
    
    % Train fis with backpropagation method
    % fnnBP is the anfis with the minimun checking error
    [trnFis, trnError, stepsize, fnnBP1, ErrorBP1] = ...
        anfis(dataset, initfnn, trnOpt, dispOpt, valueset, 0);
    % Uncomment to plot Predictions and error curves
    % Plot predictions for DATASET
%     pred = evalfis(dataset(:,1:3),fnnBP1);  %Get prediction for a set
%     plotForMe(dataset, pred, 'fnnBP1 Data set Predictions');
%     % Plot predictions for VALUESET
%     pred = evalfis(valueset(:,1:3),fnnBP1);  %Get prediction for a set
%     plotForMe(valueset, pred, 'fnnBP1 Value set Predictions');
%     % Plot predictions for CHECKSET
%     pred = evalfis(checkset(:,1:3),fnnBP1); %Get prediction for a set
%     plotForMe(checkset, pred, 'fnnBP1 Test set Predictions');
    
    % Train fis with hybrid method
    % fnnHB is the anfis with the minimun checking error
    [trnFis, trnError, stepsize, fnnHB1, ErrorHB1] = ...
        anfis(dataset, initfnn, trnOpt, dispOpt, valueset, 1);
    % Uncomment to plot Predictions and error curves
%     % Plot predictions for DATASET
%     pred = evalfis(dataset(:,1:3),fnnHB1);  %Get prediction for a set
%     plotForMe(dataset, pred, 'fnnHB1 Data set Predictions');
%     % Plot predictions for VALUESET
%     pred = evalfis(valueset(:,1:3),fnnHB1);  %Get prediction for a set
%     plotForMe(valueset, pred, 'fnnHB1 Value set Predictions');
%     % Plot predictions for CHECKSET
%     pred = evalfis(checkset(:,1:3),fnnHB1); %Get prediction for a set
%     plotForMe(checkset, pred, 'fnnHB1 Test set Predictions');
%     
    
    % Uncomment to plot learning curves
%     % Plot all the learning curves in one plot
%     figure; plot([ErrorBP0 ErrorHB0 ErrorBP1 ErrorHB1])
%     legend('BP zero order','HB zero order','BP first order', 'HB first order')
%     xlabel('Epochs')
%     ylabel('RMSE (Root Mean Squared Error)')
%     title('Error Curves')
end

function plotForMe(set, pred, tit)
    % Find size
    n = size(set,1);
    % Plot prediction and original timeseries
    t = 1:n;
    figure; plot(t, set(:,4))
    hold on; plot(t, pred(:))
    legend('original','predicted')
    xlabel('Time (sec)')
    ylabel('Mg value')
    title(tit)
    
    % Plot prediction error
    figure; plot(t, set(:,4)-pred(:))
    xlabel('Time (sec)')
    ylabel('Mg value')
    title(['Error ' tit])
end