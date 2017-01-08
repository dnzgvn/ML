function [ label,result ] = CheckPure(labels)
result=1;
[m,n] = size(labels);

label=labels(1,1);
for i=2:m
    if labels(i,1)~=label result=0;
end;

end