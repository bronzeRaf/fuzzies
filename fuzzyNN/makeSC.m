% Brouzos Rafael
% mprouzos@auth.gr
% 
% This function prepares 2 fuzzy interference systems. The training set
% is the given and the systems are both 1st order with hybrid method. One
% with least MSE in Dataset and one with least MSE on Valueset. Both are
% initialized with Substractive Clustering!
% Uncomment/comment out needed parts to get the plots of the systems.
% 
% INPUTS:   dataset -> The training dataset for the chaotic series anfis
%           valueset-> The validation set for the chaotic series anfis
%           checkset-> The check set for the chaotic series anfis
% 
% OUTPUTS:  fnn1 -> 1 order fuzzy neural network using hybrid method
%                   trained with least MSE on the dataset
%           fnn2 -> 1 order fuzzy neural network using hybrid method
%                   trained with least MSE on the valueset
% 
% Run the function to train the anfis systems. To  get the dataset in your 
% Workspace run "prepareData.m" file function
% 
% This function suits to the "prepareData.m" dataset script. 
% Keep both files together to use the training script.
% 
function [fnn1, fnn2] = makeSC(dataset, valueset, checkset)
    %initialize options with default values
    trnOpt = [16 0 0.01 0.9 1.1];
    dispOpt = [1 1 1 1];

    % FIRST ORDER SYSTEM
    % Initalize the fuzzy interference system
    initfnn = genfis2(dataset(:,1:3), dataset(:,4), [0.38 0.42 0.5 0.6]);
    
    % The initial MFs for training are shown in the plots.
    figure;
    title('Initial MF for fis')
    for input_index=1:3
        subplot(2,2,input_index)
        [x,y]=plotmf(initfnn,'input',input_index);
        plot(x,y)
        axis([-inf inf 0 1.2]);
        xlabel(['Input ' int2str(input_index)],'fontsize',10);
    end
    
    
    
    
    
    % Train fis with hybrid method
    % fnnHB is the anfis with the minimun checking error
    [fnn1, trnError, stepsize, fnn2, chkError] = ...
        anfis(dataset, initfnn, trnOpt, dispOpt, valueset, 1);
    
    
    % The final MFs after training are shown in the plots.
    figure;
    title('Final MF for fis')
    for input_index=1:3
        subplot(2,2,input_index)
        [x,y]=plotmf(fnn1,'input',input_index);
        plot(x,y)
        axis([-inf inf 0 1.2]);
        xlabel(['Input ' int2str(input_index)],'fontsize',10);
    end
    
    
    
    
    
    % Plot predictions for DATASET
    pred = evalfis(dataset(:,1:3),fnn1);  %Get prediction for a set
    plotForMe(dataset, pred, 'fnn1 Data set Predictions');
    % Plot predictions for VALUESET
    pred = evalfis(valueset(:,1:3),fnn1);  %Get prediction for a set
    plotForMe(valueset, pred, 'fnn1 Value set Predictions');
    % Plot predictions for CHECKSET
    pred = evalfis(checkset(:,1:3),fnn1); %Get prediction for a set
    plotForMe(checkset, pred, 'fnn1 Test set Predictions');
    
    % Uncomment to plot learning curves
    % Plot all the learning curves in one plot
    figure;
    plot([trnError chkError])
    legend('Dataset Error','Valueset Error')
    xlabel('Epochs')
    ylabel('RMSE (Root Mean Squared Error)')
    title('Error Curves')
    
end


function plotForMe(set, pred, tit)
    % Find size
    n = size(set,1);
    % Plot prediction and original timeseries
    t = 1:n;
%     Uncomment to plot the predicted-original values
%     figure; plot(t, set(:,4))
%     hold on; plot(t, pred(:))
%     legend('original','predicted')
%     xlabel('Time (sec)')
%     ylabel('Mg value')
%     title(tit)
    
    % Plot prediction error
    figure; plot(t, set(:,4)-pred(:))
    xlabel('Time (sec)')
    ylabel('Mg value')
    title(['Error ' tit])
end