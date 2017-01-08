clear;
load emotions_data2;
%-----------------CHANGE THESE TO TEST------------------
apply_pca=0;
samples=100;
emotion=1;
%-------------------------------------------------------
ny = convertNum(y);
subx = x(1:samples,:);
suby= ny(1:samples,emotion);


if apply_pca==1
    [COEFF, SCORE, LATENT, TSQUARED, EXPLAINED, MU] = pca(subx);
    variance_retained = cumsum(LATENT./sum(LATENT) * 100);
    [i,j] = find(variance_retained <= 95.1);
    subx = subx*COEFF(:,i);
end
tree = ConstructDecisionTree(subx,suby,0,0,0);
treeout = testTree(tree,subx);

treeout1D= convert1D(treeout);

treestat=confusionmat(treeout1D,suby);

disp(treestat);