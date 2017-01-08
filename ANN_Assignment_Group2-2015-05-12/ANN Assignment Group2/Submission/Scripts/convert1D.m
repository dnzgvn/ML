function OUT = convert1D (inMat)
[m,n] = size(inMat);
outMat = zeros(n,1);
for i=1:n
    [val,ind] = max(inMat(:,i));
    outMat(i) = ind;
end
OUT = outMat;
end

%{
this function converts the output of the ann to a 1D vector
that can be used to obtain a confusion matrix.

Index of the max value is the predicted label of the photo.

new_output = convert1D(ann_output);
cm = confusionmat(y,new_output);

%}