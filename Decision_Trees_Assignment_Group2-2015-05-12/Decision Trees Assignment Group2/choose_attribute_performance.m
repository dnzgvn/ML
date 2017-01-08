%find the best feature and threshold
%check how well the threshold performs
emotion = 1;

load('emotions_data.mat')
ny = convertNum(y)';
[bf, bt] = CHOOSE_ATTRIBUTE(x,ny(emotion,:));

featureNum = bf;
thresholdVal = bt;

eny = ny(emotion,:);
scatter(eny,x(:,featureNum));
hold on
line([0,1],[thresholdVal,thresholdVal]);