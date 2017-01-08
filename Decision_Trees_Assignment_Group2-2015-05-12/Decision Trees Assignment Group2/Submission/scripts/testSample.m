%Predicts the label for a sample

function [output] = testSample(tree,x,sample)

    if isempty(tree.kids)  %if we've reached a leaf
        output = tree.class;      %predict the label as the tree.class
        
    else
        if x(sample,tree.feature) <= tree.threshold    %if the value is larger than the threshold
            output = testSample(tree.kids{1,2},x,sample);     %select right branch 
    
        elseif x(sample,tree.feature) > tree.threshold  %if the value is smaller than the threshold
            output = testSample(tree.kids{1,1},x,sample);    %select the left branch
            
        end
    end

end