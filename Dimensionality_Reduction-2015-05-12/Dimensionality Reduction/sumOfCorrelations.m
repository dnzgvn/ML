function [ out ] = sumOfCorrelations(feature,SelectedFeatures)

[m,n]=size(SelectedFeatures);
out=[1,n];

for i=1:n
    out(1,i) = pearsonPMCC(feature,SelectedFeatures(1:end,i));
    %disp(['correlation to feature ' num2str(i) ':' num2str(out(1,i)) ]);
  
end

out=sum(out);