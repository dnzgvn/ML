function out = pearsonPMCC(X, Y) % both inputs as column vectors
[m,n] = size(X);
[o,p] = size(Y);

if m ~= o || n ~= p
    error('matrix input sizes must be the same size');
end


xMean = mean(X); % calc mean of X
yMean = mean(Y); % calc mean of Y



for i = 1:m                   %for each data point in X
    DIFFX(i) = X(i) - xMean;  %diffxi = xi - xmean
    DIFFY(i) = Y(i) - yMean;  %diffyi = yi - ymean
end   


top = sum(DIFFX.*DIFFY);
bottom =  sqrt(sum(power(DIFFX,2))) * sqrt(sum(power(DIFFY,2)))  ;
out = top/bottom;


end