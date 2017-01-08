function [ tree ] = StructTreeTest( features,labels )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(features);
[lbl,r]=CheckPure(labels);
if r==1 
    %tree.data=features;
    tree.class=lbl;
    tree.kids=cell({});
    tree.op='';
else
    tree.op='Pure?';
    sub1=StructTreeTest(features(1:ceil(m/2),1:end),labels(1:ceil(m/2),1:end));
    sub2=StructTreeTest(features(ceil(m/2)+1:end,1:end),labels(ceil(m/2)+1:end,1:end));
    tree.kids=cell({sub1,sub2});
    
end;


end



