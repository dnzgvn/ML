function [ tree ] = ConstructDecisionTree( features,labels,depth, maxdepth )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(features);
[lbl,r]=CheckPure(labels);
ent=Entropy(labels);

    

if r==1 || depth==maxdepth
    %tree.data=features;
    tree.class=lbl;
    %tree.data=features
    tree.kids=cell({});
    tree.op='';
else
    disp(['Entropy' num2str(ent)]);
    disp('parsing tree...');
    [feature, threshold] = CHOOSE_ATTRIBUTE(features,labels')
    tree.op=['Feature= ' num2str(feature) ' Threshold=' num2str(threshold)];
    %tree.op=['Feature=' num2str(feature) ];
    tree.feature=feature;
    tree.threshold=threshold;
    disp(tree.op);
    
    
    indices=find(features(:,feature)>threshold);
    kid1=features(indices,:);
    kidlbl1=labels(indices);
    
    indices2=find(features(:,feature)<=threshold);
    kid2=features(indices2,:);
    kidlbl2=labels(indices2);
    
    sub1=ConstructDecisionTree(kid1,kidlbl1, depth+1,maxdepth);
    sub2=ConstructDecisionTree(kid2,kidlbl2, depth+1,maxdepth);
    tree.kids=cell({sub1,sub2});
    
end;


end

