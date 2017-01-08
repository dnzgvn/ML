clear;

%network parameter setup(play around with these)
hidden_layers=[9 9 8 8]; %number of neurons for each hidden layer
layer_functions={'tansig' 'tansig' 'tansig' 'tansig' 'tansig'}; %options: tansig purelin logsig
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
%learning_rate = 0.1;

trainRatio = 0.7;
valRatio = 0.3;
testRatio = 0.0;

load emotions_data;



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
fold_perf = zeros(10,2); %[train test] performances



for k = 1:K  %for each group
    
    disp(['Training fold ' num2str(k) ' of ' num2str(K)]);
    
    fold_matrix = zeros();
    
    net = newff(tx,tny,hidden_layers,layer_functions,'trainlm','learngdm','mse');  %create the network


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
    %net.trainParam.lr = learning_rate;
    
    
    test_set = (fold_indices == k); %current group is in the test set
    train_set = ~test_set;  %all other 9 are in the training set
    train_ind = svector(train_set);  %converts true/false to index numbers
    test_ind = svector(test_set);
    
    [net,tr,Y,E] = train(net,tx(:,train_ind),tny(:,train_ind)); %trains with the 9 other groups
    
    fold_perf(k,1) = mse(tny(:,train_ind)-Y); %mse to track overfitting
    youtput(:,test_ind) = sim(net, tx(:,test_ind));  %simulates with the test group
    
    fold_perf(k,2) = mse(tny(:,test_ind)-youtput(:,test_ind)); %mse to track overfitting
    
    fold_matrix = youtput(:,test_ind);
    fold_1doutput = convert1D(fold_matrix);
    fold_stat = confusionmatStats(y(test_ind),fold_1doutput);
    disp(['--------FOLD NUMBER ' num2str(k) '--------']);
    disp(['Fold ' num2str(k) ' Confusion Matrix :']);
    disp(fold_stat.confusionMat);%confusion matrix of the folds
    fold_matrices(:,:,k) = fold_stat.confusionMat;
    
    disp(['Fold ' num2str(k) ' Recall :']);
    disp('    1         2         3         4         5         6');
    disp(fold_stat.recall');
    fold_recall(k,:) = fold_stat.recall';
    
    disp(['Fold ' num2str(k) ' Precision :']);
    disp('    1         2         3         4         5         6');
    disp(fold_stat.precision');
    fold_precision(k,:) = fold_stat.precision';
    
    disp(['Fold ' num2str(k) ' F-score :']);
    disp('    1         2         3         4         5         6');
    disp(fold_stat.Fscore');
    fold_Fscore(k,:) = fold_stat.Fscore';
    
    disp(['Accuracy of fold ' num2str(k) ' = ' num2str(fold_stat.accuracy*100) '%']);
    
    disp(['mse of training output = ' num2str(fold_perf(k:1)) 'mse of testing output = ' num2str(fold_perf(k:2))]);
    
end

d1youtput = convert1D(youtput);  %converts to 1D with the predicted labels
stat = confusionmatStats(y,d1youtput);  %statistics
disp(stat.confusionMat);%confusion matrix of the total
disp('    1         2         3         4         5         6');
disp(stat.recall');
disp('    1         2         3         4         5         6');
disp(stat.precision');
disp('    1         2         3         4         5         6');
disp(stat.Fscore');
disp(['Average accuracy between all folds = ' num2str(stat.accuracy*100) '%']);


disp('----------------ALL DATA TEST---------------');
alldata_youtput = sim(net, tx);
alldata_perf = mse(tny-alldata_youtput);%mse to track overfitting
disp(['MSE ' num2str(alldata_perf)]);
alldata_d1youtput = convert1D(alldata_youtput);  %converts to 1D with the predicted labels
alldata_stat = confusionmatStats(y,alldata_d1youtput);  %statistics

disp(alldata_stat.confusionMat);%total is included in the lab report  %average
disp('    1         2         3         4         5         6');
disp(alldata_stat.recall');  %average should be taken 
disp('    1         2         3         4         5         6');
disp(alldata_stat.precision');  %average should be taken 
disp('    1         2         3         4         5         6');
disp(alldata_stat.Fscore');  %average should be taken 
disp(['Accuracy using all data = ' num2str(alldata_stat.accuracy*100) '%']);