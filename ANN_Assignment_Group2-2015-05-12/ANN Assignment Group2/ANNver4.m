%network parameter setup(play around with these)
hidden_layers=[10 10]; %number of neurons for each hidden layer
layer_functions={'tansig' 'tansig' 'tansig'}; %options: tansig purelin logsig
epochs = 100;
show = 5;
time = 60;
goal=0;
min_grad=1e-07;
max_fail=6;
mu = 0.001;
mu_dec=0.1;
mu_inc=10;
mu_max=10000000000




load emotions_data; %Loads the face data

%c = cvpartition(y,'k',10);

[inputs,targets]=zipShuffSplit(x,y);  %randomly shuffles data keeping inputs and labels intact

%10-fold splitting of data to a training and test set
[train_input,test_input]=foldThis(inputs,10,0.3);
[train_target,test_target]=foldThis(targets,10,0.3);


%prepare data for training and testing
inputs=train_input';
targets = convertNum(train_target)';
test_input=test_input';


%setup the network
net=newff(inputs, targets, hidden_layers,layer_functions);
net.trainParam.epochs = epochs;
net.trainParam.show = show;
net.trainParam.time = time;
net.trainParam.goal = goal;
net.trainParam.min_grad = min_grad;
net.trainParam.max_fail = max_fail;
net.trainParam.mu= mu;
net.trainParam.mu_dec=mu_dec;
net.trainParam.mu_inc=mu_inc;
net.trainParam.mu_max=mu_max;

net.divideFcn = ''; %required to prevent training to split data automatically further

%train the network
[net,tr] = train(net, inputs, targets);

%test the network and output a confusion matrix
youtput = sim(net, test_input);
new_output = convert1D(youtput);

%cm = confusionmat(test_target,new_output);
[c,cm,ind,per] = confusion(targets,network1_outputs)
