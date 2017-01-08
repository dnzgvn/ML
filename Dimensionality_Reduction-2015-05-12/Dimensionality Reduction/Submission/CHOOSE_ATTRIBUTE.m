
%   c4.5 algorithm for deterimining threshold value
%   for each value of the feature sort values
%   take the min of each pair as threshold  
%   for each threshold, sort into two groups: less than and larger than
%   compute the resulting info gain
%   max info gain = threshold


function [best_feature, best_threshold] = CHOOSE_ATTRIBUTE(features,targets)

[x_sample,x_feature] = size(features);

ChooseAttrMat = zeros(x_feature,3);


for f = 1:x_feature   
    
    totalEntropy = Entropy(targets);
    
    unique_features = unique(features(:,f)); %get unique values of the feature -- has trouble with double values
    [u_sample,u_feature] = size(unique_features); 
    sortedFeatures = sort(unique_features,f); %sort unique values
    
    SplitInfoGain = zeros(u_sample-1,3);
    
    for sF = 1:(u_sample-1)
        
        SamplesLargerThan = 0;
        SamplesLessThan = 0;
        T1Entropy = 0;
        T2Entropy = 0;
        Remainder = 0;
        
        midPoint = (sortedFeatures(sF,1) + sortedFeatures(sF+1,1)) / 2;
        midPoints{sF,1} = midPoint;
        %minValue = min(sortedFeatures(sF,1),sortedFeatures(sF+1,1)); %select min value of the pair as threshold
        SamplesLargerThan = find(features(:,f)>midPoint);  %indices of samples larger than threshold
        SamplesLessThan = find(features(:,f)<=midPoint);  %indices of samples less than threshold
    
        
        T1Entropy = Entropy(targets(SamplesLargerThan)); %Entropy for group 1
       
        T2Entropy = Entropy(targets(SamplesLessThan));  %Entropy for group 2
        
        %Remainder calc for feature f based on this threshold
        Remainder = ((length(SamplesLargerThan)/x_sample)*T1Entropy)+((length(SamplesLessThan)/x_sample)*T2Entropy);
        
        SplitInfoGain(sF,1) = totalEntropy - Remainder;  %information gain of feature  f based on this threshold
        SplitInfoGain(sF,2) = midPoint;  %threshold
        SplitInfoGain(sF,3) = f;
    end
    [M,I] = max(SplitInfoGain(:,1));
    ChooseAttrMat(f,:) = SplitInfoGain(I(1),:);
end
[attM,attI] = max(ChooseAttrMat(:,1));
best_feature = ChooseAttrMat(attI(1),3);
best_threshold = ChooseAttrMat(attI(1),2);
end



