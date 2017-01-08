function [ inputtrain,inputtest,inputvalidate,targettrain,targettest,targetvalidate ] = ThreeWaySplitNfold( input_data, target,n,r )
%CustomANN Script implementation of an Artificial Neural Network
%   Work in progress

[input_data,target]=zipShuffSplit(input_data,target) %shuffle data keeping inputs and labels intact
[inputtrain,inputtest]=foldThis(input_data,n,r) %n-fold for input data split for test
[targettrain,targettest]=foldThis(target,n,r) %n-fold for target data split for test

[inputtrain,targettrain]=zipShuffSplit(inputtrain,targettrain) %shuffle training set
[inputtrain, inputvalidate]=foldThis(inputtrain,n,r) %1n-fold for data split for validation
[targettrain, targetvalidate]=foldThis(targettrain,n,r)%n-fold for data split for validation




end

