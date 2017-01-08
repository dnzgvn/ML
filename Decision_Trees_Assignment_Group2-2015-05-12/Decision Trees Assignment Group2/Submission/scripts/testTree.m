%Decision tree test function

function r = testTree(tree,x)
[samples,~] = size(x);
r = zeros(1,samples);
for s=1:samples  %for every sample in data
    r(1,s) = testSample(tree,x,s);  %predict a label
end