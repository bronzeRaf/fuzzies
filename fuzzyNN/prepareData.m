% Brouzos Rafael
% mprouzos@auth.gr
% 
% This function prepares the dataset for an anfis system. The training set
% is based on the chaotic timeseries of Mackey-Glass. Dataset gets 3 old
% values of the timeseries as attributes and 1 future value as a class
% value.
% 
% INPUTS:   path -> the full path to the matlab saved workspace with the
% values of the Mackey-Glass differential equation.
%           old1 -> number of samples backward for the first attribute
%           old2 -> number of samples backward for the second attribute
%           old3 -> number of samples backward for the third attribute
%           p    -> number of samples forward for the class value
% 
% OUTPUTS:  dataset -> The training dataset for the chaotic series anfis
%           checkset-> The check set for the chaotic series anfis
%           testset -> The test set for the chaotic series anfis
% 
% Run the function to get the dataset in your Workspace and train an anfis.
% 
% This function suits to the rest anfis training scripts. 
% Keep both files together to use the training script.
% 

function [dataset, valueset, checkset, testset] = prepareData(path, old1, old2, old3, p)
    % Load data from the given path
    mg = load(path);
    
    % Set the sizes of the sets
    No = 500;
    Nval = 300;
    Ntrn = 600;
    Nchk = 600;
    
    % Initialize
    dataset = zeros(Ntrn,4);
    valueset = zeros(Nval,4);
    checkset = zeros(Nchk,4);
    
    % Dataset construction
    start = No;
    dataset(:,1) = mg(start-old1:(start-old1)+Ntrn-1,2);
    dataset(:,2) = mg(start-old2:(start-old2)+Ntrn-1,2);
    dataset(:,3) = mg(start-old3:(start-old3)+Ntrn-1,2);
    dataset(:,4) = mg(start+p:start+Ntrn+p-1,2);
    
    % Value set construction
    start = No+Ntrn;
    valueset(:,1) = mg(start-old1:(start-old1)+Nval-1,2);
    valueset(:,2) = mg(start-old2:(start-old2)+Nval-1,2);
    valueset(:,3) = mg(start-old3:(start-old3)+Nval-1,2);
    valueset(:,4) = mg(start+p:start+Nval+p-1,2);
    
    % Check set construction
    start = No+Ntrn+Nval;
    checkset(:,1) = mg(start-old1:(start-old1)+Nchk-1,2);
    checkset(:,2) = mg(start-old2:(start-old2)+Nchk-1,2);
    checkset(:,3) = mg(start-old3:(start-old3)+Nchk-1,2);
    checkset(:,4) = mg(start+p:start+Nchk+p-1,2);
    
    % Test set construction
    start = No+Ntrn+Nval+Nchk;
    testset(:,1) = mg(start-old1:end-old1-p,2);
    testset(:,2) = mg(start-old2:end-old2-p,2);
    testset(:,3) = mg(start-old3:end-old3-p,2);
    testset(:,4) = mg(start+p:end,2);


end