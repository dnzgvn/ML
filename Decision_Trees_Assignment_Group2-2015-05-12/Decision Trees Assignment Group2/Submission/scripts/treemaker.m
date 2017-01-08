load('emotions_data2.mat');
emotion=1;

target=FilterTargets(y,emotion);
t=treefit(x,target);
treedisp(t);

