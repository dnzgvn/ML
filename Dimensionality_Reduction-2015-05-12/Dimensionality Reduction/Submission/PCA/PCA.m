load emotions_data;

[COEFF, SCORE, LATENT, TSQUARED, EXPLAINED, MU] = pca(x);

% select smallest k that retains 95% variance
variance_retained = cumsum(LATENT./sum(LATENT) * 100);
%k=43

% draw scatter plot of the first two PCs
% anger     = r, 
% disgust   = g, 
% fear      = b, 
% happiness = c,
% sadness   = m, 
% surprise  = y

figure
xlabel('First Principal Component');
ylabel('Second Principal Component');
title('Principal Component Scatter Plot');
scatter(SCORE(y==1,1),SCORE(y==1,2),'r');
hold on
scatter(SCORE(y==2,1),SCORE(y==2,2),'g');
scatter(SCORE(y==3,1),SCORE(y==3,2),'b');
scatter(SCORE(y==4,1),SCORE(y==4,2),'c');
scatter(SCORE(y==5,1),SCORE(y==5,2),'m');
scatter(SCORE(y==6,1),SCORE(y==6,2),'y');

