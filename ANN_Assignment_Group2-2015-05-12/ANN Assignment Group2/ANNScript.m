
clear;
clc;

load emotions_data; %Loads the face data

[xtrain,xtest,xvalid,ytrain,ytest,yvalid]=ThreeWaySplitNfold(x,y,10,0.3) %Splits data to train,test and validate set

training_input = xtrain';
testing_input = xtest'; 

training_target = convertNum(ytrain)'; %training target
testing_target = convertNum(ytest)'; %testing target

input_sample = xvalid';
target_sample = convertNum(yvalid)';


net = newff(training_input, training_target, [10 10],{'tansig' 'tansig' 'tansig'});

net.trainParam.epochs = 20;
net.trainParam.show = 5;


[net,tr] = train(net, training_input, training_target);

yout = sim(net, training_input);

%new_output = convert1D(yout);

%[c,cm,ind,per] = confusion(ytest,new_output);

[c,cm,ind,per] = confusion(testing_target,yout);

figure(1);

hold on;
plot(yout, '-or');
plot(testing_target(:,:), '-ob');

