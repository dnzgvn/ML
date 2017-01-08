clear;
load('emotions_data2.mat');

F=x;
newY=convertNum(y);
S_k=[];
r_cf=[];
r_ff=[];
calc=[];
valmon=[];

for e=1:1
    
for k=1:100 % <--- supposed to stop k when calcCFS value starts to drop.
    
[m,n]=size(F);    
for j=1:n    
  f=F(:,j);
  r_cf(e,j) = pearsonPMCC(f,newY(1:end,e)); % <--- correllation between feature and label
  %disp(['feature ' num2str(j)  ' correlation to target:' num2str(r_cf(e,j))]);
  
  r_ff(e,j) = sumOfCorrelations(f,S_k); % <--- sum of correlations between features.
  
  
  calcCFS(e,j) = r_cf(e,j)/sqrt(k+2*r_ff(e,j)); % <--- CFS calculated for each feature
  
end

[maxVal,maxIdx] = max(calcCFS); %<--- find feature which has maximum CFS for this iteration
if (k>1) & (maxVal<valmon(end)) 
    disp('dropping');
else
    disp('increasing');
end
valmon(end+1)=maxVal;
S_k(:,k) = F(:,maxIdx); %<--- found feature copied to S_k
F(:,maxIdx)=[]; %<--- found feature removed from F

disp(['k=' num2str(k) ' maxVal=' num2str(maxVal)]);
end
  
end    
    
    




