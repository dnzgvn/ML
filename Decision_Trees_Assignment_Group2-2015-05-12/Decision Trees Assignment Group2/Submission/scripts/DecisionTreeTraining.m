function [ tree ] = DecisionTreeTraining( inputs,targets,emotion,maxdepth )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    
    
    labels=FilterTargets(targets,emotion);
    
    tree = ConstructDecisionTree(inputs,labels,0,maxdepth);
    
    DrawDecisionTree(tree,['Tree output for emotion=' num2str(emotion)]);

end

