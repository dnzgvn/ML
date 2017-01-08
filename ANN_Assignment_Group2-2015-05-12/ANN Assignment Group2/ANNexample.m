K = 10;
fold_indices = crossvalind('Kfold',y,K); %all the samples are grouped into one of the 10 folds
%don't know if it's ok to use this

svector = 1:612;

tny = convertNum(y)';
tx = x';

youtput = zeros(6,612);

for k = 1:K  %for each group
    
    net = newff(tx,tny,10,{'tansig','tansig'},'trainlm','learngdm','mse');  %create the network
    net.divideFcn = 'dividerand';
    net.divideParam.trainRatio = 0.7;
    net.divideParam.valRatio = 0.15;
    net.divideParam.testRatio = 0.15;
    net.trainParam.show = 5;
    net.trainParam.epochs = 100;
    net.trainParam.time = 60;
    net.trainParam.goal = 0.001; 
    
    test_set = (fold_indices == k); %current group is in the test set
    train_set = ~test_set;  %all other 9 are in the training set
    train_ind = svector(train_set);  %converts true/false to index numbers
    test_ind = svector(test_set);    

    [net,tr] = train(net,tx(:,train_ind),tny(:,train_ind)); %trains with the 9 other groups
    youtput(:,test_ind) = sim(net, tx(:,test_ind));  %simulates with the test group
    
    


end

d1youtput = convert1D(youtput);  %converts to 1D with the predicted labels
stat = confusionmatStats(y,d1youtput);  %statistics
