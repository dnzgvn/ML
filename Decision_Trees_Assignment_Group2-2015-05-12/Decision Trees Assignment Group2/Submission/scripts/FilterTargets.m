function [ out ] = FilterTargets( targets,wanted_label )
%This function takes label vectors and returns a vector only setting the
%wanted label to 1 and the rest to zero
[m,n]=size(targets);
out=zeros(1:n,1);
for i=1:size(targets)
    if targets(i,1)==wanted_label 
        out(i,1)=1
    else
        out(i,1)=0
    end
end


end

