clear;
load emotions_data;

[samples,features] = size(x);
emotions = 6;
K = 10;

output = zeros(emotions,samples);  %test output
fold_matrices = zeros(6,6,K);  %confusion matrix for each fold
fold_recall = zeros(K,6);  %recall for each fold
fold_precision = zeros(K,6);  %precision for each fold
fold_Fscore = zeros(K,6);  %Fscore for each fold
%fold_variance_retained = zeros(K,features); %variance coverage for each fold's training set

%prepare data
ny = convertNum(y);


%data preprocessing with pca
[COEFF, SCORE, LATENT, TSQUARED, EXPLAINED, MU] = pca(x);
variance_retained = cumsum(LATENT./sum(LATENT) * 100);
[i,j] = find(variance_retained <= 95.1);
x_reduced = x*COEFF(:,i);  %reduced features mapped back to original space



%all the samples are grouped into one of the 10 folds

fold_indices = crossvalind('Kfold',y,K);




for k = 1:K  %for each group
    COEFF = 0;
    
    disp(['Training fold ' num2str(k) ' of ' num2str(K)]);
    
    test_set = (fold_indices == k); %current group is in the test set
    train_set = ~test_set;  %all other 9 are in the training set
    %train_ind = svector(train_set);  %converts true/false to index numbers
    %test_ind = svector(test_set);
    
    
    for e=1:emotions
        disp(['Emotion=' num2str(e)]);
        trees(k,e).tree = ConstructDecisionTree(x_reduced(train_set,:), ny(train_set,e),0,0,0); %learns with the 9 other groups
        %DrawDecisionTree(trees(e).tree,num2str(e));                              
        
        output(e,test_set) = testTree(trees(k,e).tree, x_reduced(test_set,:));  %tests with the test group
        trees(k,e).cm = confusionmat(ny(test_set,e)',output(e,test_set));
        disp(trees(k,e).cm);
        
        %fold_matrices(:,:,e,k) = cm;
      
    end
    
    fold_matrix = output(:,test_set);
    fold_1doutput = convert1D(fold_matrix);  %calc confusion matrix of the fold
    fold_stat = confusionmatStats(y(test_set),fold_1doutput);  %fold stats
    fold_matrices(:,:,k) = fold_stat.confusionMat;
    fold_recall(k,:) = fold_stat.recall';  %calc recall rate of the fold
    fold_precision(k,:) = fold_stat.precision';  %calc precision rate of the fold
    fold_Fscore(k,:) = fold_stat.Fscore'; %calc f score of the fold
      
end


all_data_output = convert1D(output);  %converts to 1D with the predicted labels
stat = confusionmatStats(y,all_data_output);  %statistics
disp(stat.confusionMat);
 
%calc avg confusion matrix of the crossvalidation

%calc avg recall and precision rates of the crossvalidation

%calc avg F1 score of the of the crossvalidation

%print The acquired decision trees, trained on the whole available dataset
%(6 in total, for 6 different emotions).