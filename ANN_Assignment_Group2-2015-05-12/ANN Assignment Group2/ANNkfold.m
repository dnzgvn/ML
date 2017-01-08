clear;

%network parameter setup(play around with these)
hidden_layers=[10 10]; %number of neurons for each hidden layer
layer_functions={'tansig' 'tansig' 'tansig'}; %options: tansig purelin logsig
epochs = 1000;
show = 25;
time = 200;
goal=0;
min_grad=1e-07;
max_fail=6;
mu = 0.001;
mu_dec=0.1;
mu_inc=10;
mu_max=10000000000;
show_window=false;
showCommandLine=true;

load emotions_data2;

K = 10;
fold_indices = crossvalind('Kfold',y,K); %all the samples are grouped into one of the 10 folds
%don't know if it's ok to use this

svector = 1:612;

tny = convertNum(y)';
tx = x';

youtput = zeros(6,612);

for k = 1:K  %for each group
    
    net = newff(tx,tny,hidden_layers,layer_functions,'trainlm','learngdm','mse');  %create the network
    net.divideFcn = '';
   
    
    
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
    net.trainParam.showWindow = show_window;
    net.trainParam.showCommandLine=showCommandLine;

    test_set = (fold_indices == k); %current group is in the test set
    train_set = ~test_set;  %all other 9 are in the training set
    train_ind = svector(train_set);  %converts true/false to index numbers
    test_ind = svector(test_set);    

    [net,tr] = train(net,tx(:,train_ind),tny(:,train_ind)); %trains with the 9 other groups
    youtput(:,test_ind) = sim(net, tx(:,test_ind));  %simulates with the test group
    
    


end

d1youtput = convert1D(youtput);  %converts to 1D with the predicted labels
stat = confusionmatStats(y,d1youtput);  %statistics
