function OUT = convertNum (inMat)
[m,n] = size(inMat);
outMat = zeros(m,6);
for j = 1:m   
    OUTA = [0 0 0 0 0 0];
    OUTA(inMat(j)) = 1;
    outMat(j,1:6) = OUTA;
end
OUT = outMat;
end
