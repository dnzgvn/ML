clear;
load emotions_data2;
%-----------------CHANGE THESE TO TEST------------------
apply_cfs=1;
samples=100;
emotion=1;
%-------------------------------------------------------
ny = convertNum(y);
subx = x(1:samples,:);
suby= ny(1:samples,emotion);


if apply_cfs==1
    
    [subx,valmon] = CFSFun(x,y,1);
end
tree = ConstructDecisionTree(subx,suby,0,0,0);
treeout = testTree(tree,subx);

treeout1D= convert1D(treeout);

treestat=confusionmat(treeout1D,suby);

disp(treestat);