%CFS-TJG rev 1a ((the version that crashes half way though))
clear;
load emotions_data;

F = x;
S_k = [];
r_ff = [0];
yNew = convertNum(y); % y in useful format
k = 1; %start at first iterations
e = 1; %which emotion
r_cf = [];
valmon = [];

while(k<100) % CFS is dropping  %%KLUDGE  KLUDGE  KLUDGE  KLUDGE!!!!!!  
    
    [m,n] = size(F);    %check the size of the current set of features F
    for i = 1:n         %each feature f in F
        r_cf(k,n) = pearsonPMCC(F(:,n),yNew(:,e));
    end

    for i = 1:n         % each feature f in F
        [S_k_m, S_k_n] = size(S_k); %check size of selected features s_k
        for j = 1:S_k_n       %each feature in the feature set %% ERROR??? 
            r_ff(k,n) = pearsonPMCC(F(:,n),S_k(:,j));
        end
        
    end
    
    %from CFS equation:
    top = sum(r_cf(k,:));
    bottom = sqrt(k + 2*(sum(r_ff(k,:))));
    CFS(k) = top/bottom;
    %find maximum CFS and its potision
    [maxCFS, maxCFSindex] = max(CFS);
    
    S_k(:,end+1) = F(:,maxCFSindex); % add it to selected feature set
    F(:,maxCFSindex) = [];           % remove it from initial feeature set
    valmon(end+1)=maxCFS;
    %disp(S_k);
    k = k+1;
    disp(k);
    %input('more?');
    %plot(valmon);
end

