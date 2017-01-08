clear;
load emotions_data2;

[samples,features] = size(x);
emotions = 6
fold_matrices = zeros(2,2,emotions,10);  %confusion matrix for each fold
output = zeros(samples,emotions);

%prepare data
ny = convertNum(y);


%all the samples are grouped into one of the 10 folds
K = 10;
fold_indices = crossvalind('Kfold',y,K);




for k = 1:K  %for each group
    
    disp(['Training fold ' num2str(k) ' of ' num2str(K)]);
    
    test_set = (fold_indices == k); %current group is in the test set
    train_set = ~test_set;  %all other 9 are in the training set
    %train_ind = svector(train_set);  %converts true/false to index numbers
    %test_ind = svector(test_set);
    
    for e=1:emotions
        disp(['Emotion=' num2str(e)]);
        trees(e).tree = ConstructDecisionTree(x(train_set,:), ny(train_set,e),0,0); %learns with the 9 other groups
        %DrawDecisionTree(trees(e).tree,num2str(e));                              
        
        output(e,test_set) = testTree(trees(e).tree, x(test_set,:));  %tests with the test group
        trees(e).cm = confusionmat(ny(test_set,e)',output(e,test_set));
        disp(trees(e).cm);
        
        %fold_matrices(:,:,e,k) = cm;
      
    end
   
    
    %calc confusion matrix of the fold
    
    %calc avg recall and precision rates of the fold
    
    %calc F1 score of the fold
    
end
%{
for ie = 1:emotions
disp(confusionmat(ny(:,ie)',output(ie,:)));
end
%}
%calc avg confusion matrix of the crossvalidation

%calc avg recall and precision rates of the crossvalidation

%calc avg F1 score of the of the crossvalidation

%print The acquired decision trees, trained on the whole available dataset
%(6 in total, for 6 different emotions).