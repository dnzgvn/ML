function [trainData, testData] = foldThis(inputData, n, r) %n = real num, r = ratio 0 to 1

% create output bin test
[n m] = size(inputData);

trainDataBin = zeros(round(r*n),m);
testDataBin  = zeros(round(n*(1*r)),m);



% create indexes to access data:

[trainInd,valInd,testInd] = divideint(n,r,0,1-r); %(Q,trainRatio,valRatio,testRatio)


for p = 1:size(trainInd')
trainDataBin(p,1:end) = inputData(trainInd(p),1:end);
end

for p = 1:size(testInd')
testDataBin(p,1:end) = inputData(testInd(p),1:end);
end

trainData = trainDataBin;
testData = testDataBin;


end
