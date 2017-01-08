function [correlated_features, valmon] = CFSFun3(x,y,e)
global valmon;
F = x;
S_k = [];
r_ff = [0];
yNew = convertNum(y); % y in useful format
k = 1; %start at first iterations
 %which emotion
r_cf = [];
valmon = [0 1];
drawing = 0;

while(k<135) % CFS is dropping  %%KLUDGE  KLUDGE  KLUDGE  KLUDGE!!!!!!  
    
    [m,n] = size(F);    %check the size of the current set of features F
    for i = 1:n         %each feature f in F
        r_cf(1,i) = pearsonPMCC(F(:,n),yNew(:,e));
        [S_k_m, S_k_n] = size(S_k); %check size of selected features s_k
        
        if k>1
            for j = 1:S_k_n       %each feature in the feature set %% ERROR??? 
                r_ff(1,j) = pearsonPMCC(F(:,n),S_k(:,j));
            end
        end
        top = k*mean(r_cf(1,:));
        bottom = sqrt(k+(k-1)*mean(r_ff(1,:)));
    
        CFS(k) = top/bottom;
    end
    
     if k==1
        [maxCFS, maxCFSindex] = max(r_cf);
     else
        [maxCFS, maxCFSindex] = max(CFS);
     end
     disp([num2str(k) ' top:' num2str(top) ' bottom:' num2str(bottom) ' MAXCFS:' num2str(maxCFS)] );
    
     S_k(:,end+1) = F(:,maxCFSindex); % add it to selected feature set
     F(:,maxCFSindex) = NaN;           % remove it from initial feeature set
    
     k = k+1;

    
    %from CFS equation:
    %top = sum(r_cf(k,:));
    %bottom = sqrt(k + 2*(sum(r_ff(k,:))));
    
    %find maximum CFS and its potision
    
    
    %disp([int2str(maxCFSindex) '<-- max CFS index']);    
    
    
    valmon = CFS;
    
    correlated_features = S_k; 
end

