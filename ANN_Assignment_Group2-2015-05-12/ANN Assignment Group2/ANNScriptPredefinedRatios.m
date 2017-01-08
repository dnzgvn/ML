clear;
clc;

load emotions_data; %Loads the face data

input=x';
target=convertNum(y)';

net = newff(input, target, [10 10],{'tansig' 'tansig' 'tansig'});

net.trainParam.epochs = 20;
net.trainParam.show = 5;
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.1;
net.divideParam.testRatio = 0.1;

[net,tr] = train(net, input, target);





yout = sim(net, input);
new_output = convert1D(yout);

%cm = confusionmat(ytest,new_output);
%[c,cm,ind,per] = confusion(testing_target',new_output);

[c,cm,ind,per] = confusion(target,yout);

figure(1);

hold on;
plot(yout, '-or');
plot(target(:,:), '-ob');


