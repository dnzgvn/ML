load('emotions_data.mat')
p = princomp(x);
x_reduced = x*p(:,1:43);
ny = convertNum(y);
[ysamples,ytargets] = size(ny);
outputs = zeros(ytargets,ysamples);
confusionmats = zeros(ytargets,ytargets,ytargets);

for e=1:ytargets
    trees(1,e).tree = ConstructDecisionTree(x_reduced, ny(:,e),0,0);
    outputs(e,:) = testTree(trees(1,e).tree,x_reduced);
    trees(1,e).cm = confusionmat(ny(:,e),outputs(e,:));
end

all_data_output = convert1D(outputs);  %converts to 1D with the predicted labels
stat = confusionmatStats(y,all_data_output);  %statistics
disp(stat.confusionMat);