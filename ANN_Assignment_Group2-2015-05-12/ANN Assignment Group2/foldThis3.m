function [trainData, valData, testData] = foldThis3(inputData , r1 , r2 , r3 ) 
% splits data into three sets. r1 r2 and r3 must sum to 1.
if (r1+r2+r3) == 1
    [m, n] = size(inputData);

    %  There used to be some rounding functions here (for reference)

    %  create indexes to access data:
    [trainInd,valInd,testInd] = divideint(m,r1,r2,r3); %(Q,trainRatio,valRatio,testRatio)

    disp(testInd);

    [trn_m, trn_n] = size(trainInd);
    [val_m, val_n] = size(valInd);
    [tst_m, tst_n] = size(testInd);

    trainDataBin = zeros(trn_n,n);
    valDataBin   = zeros(val_n,n);
    testDataBin  = zeros(tst_n,n);


    for p = 1:trn_n
    trainDataBin(p,:) = inputData(trainInd(p),:);
    end

    for p = 1:val_n
    valDataBin(p,:) = inputData(valInd(p),:);
    end

    for p = 1:tst_n
    testDataBin(p,:) = inputData(testInd(p),:);
    end

    trainData = trainDataBin;
    valData = valDataBin;
    testData = testDataBin;
   
else
    trainData = [];
    valData = [];
    testData = [];
    error ('Error: Ratios must add up to 1');
end
end
