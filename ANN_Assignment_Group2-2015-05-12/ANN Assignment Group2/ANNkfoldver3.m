clear;

%network parameter setup(play around with these)
hidden_layers=[10 10]; %number of neurons for each hidden layer
layer_functions={'tansig' 'tansig' 'tansig'}; %options: tansig purelin logsig
epochs = 100;%1000;
show = 5;%25;
time = 100;%200;
goal=0.001;
min_grad=1e-07;
max_fail=6;
mu = 0.001;
mu_dec=0.1;
mu_inc=10;
mu_max=10000000000;
show_window=false;
showCommandLine=true;

trainRatio = 0.7;
valRatio = 0.3;
testRatio = 0;

load emotions_data2;



tny = convertNum(y)';
tx = x';

K = 10;
fold_indices = crossvalind('Kfold',y,K); %all the samples are grouped into one of the 10 folds
%don't know if it's ok to use this
[m,n]=size(tx);

svector = 1:n;

youtput = zeros(6,n);
fold_recall = zeros(10,6);  %recall for each fold
fold_precision = zeros(10,6);  %precision for each fold
fold_Fscore = zeros(10,6);  %Fscore for each fold
fold_matrices = zeros(6,6,10);  %confusion matrix for each fold

for k = 1:K  %for each group
    
    disp(['Training fold ' num2str(k) ' of ' num2str(K)]);
    
    fold_matrix = zeros();
    net = newff(tx,tny,hidden_layers,layer_functions,'trainlm','learngdm','mse');  %create the network
    net.divideFcn = 'divideblock';
    
    net.divideParam.trainRatio = trainRatio;
    net.divideParam.valRatio = valRatio;
    net.divideParam.testRatio = testRatio;
   
    
    
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
    
    fold_matrix = youtput(:,test_ind);
    fold_1doutput = convert1D(fold_matrix);
    fold_stat = confusionmatStats(y(test_ind),fold_1doutput);
    disp(fold_stat.confusionMat);%not included in the lab report
    fold_matrices(:,:,k) = fold_stat.confusionMat;
    disp('    1         2         3         4         5         6');
    disp(fold_stat.recall');
    fold_recall(k,:) = fold_stat.recall';
    disp('    1         2         3         4         5         6');
    disp(fold_stat.precision');
    fold_precision(k,:) = fold_stat.precision';
    disp('    1         2         3         4         5         6');
    disp(fold_stat.Fscore');
    fold_Fscore(k,:) = fold_stat.Fscore';
    
    disp(['Accuracy of fold ' num2str(k) ' = ' num2str(fold_stat.accuracy*100) '%']);
    


end

d1youtput = convert1D(youtput);  %converts to 1D with the predicted labels
stat = confusionmatStats(y,d1youtput);  %statistics
disp(stat.confusionMat);%total is included in the lab report
disp('    1         2         3         4         5         6');
disp(stat.recall');
disp('    1         2         3         4         5         6');
disp(stat.precision');
disp('    1         2         3         4         5         6');
disp(stat.Fscore');
disp(['Average accuracy between all folds = ' num2str(stat.accuracy*100) '%']);