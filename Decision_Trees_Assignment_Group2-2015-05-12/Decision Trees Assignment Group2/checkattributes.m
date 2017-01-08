function [ pvout,nvout ] = checkattributes( input, target )
%this function takes a single sample, check it's attributes against a
%single target and splits it into positive and negative vectors

[m,n]=size(input);


pvout=cell(1:m,1:n);
nvout=cell(1:m,1:n);

for i=1:m
    pout=[];
    nout=[];
    for j=1:n
        
        if target(i,1)==1 
            pout(end+1)= input(i,j);
        else
            nout(end+1)= input(i,j);
    
        end
    end
    for j=1:n
        pvout{i,j}=pout;
        nvout{i,j}=nout;
    end
end

end

