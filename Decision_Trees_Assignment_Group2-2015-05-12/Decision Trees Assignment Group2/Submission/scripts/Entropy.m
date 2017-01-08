function OUT = Entropy (inMat)
%Calculates total Entropy before splitting

[~,sample] = size(inMat);
Entropy = 0;
posRatio = 0;
negRatio = 0;


    posRatio = sum(ismember(inMat, 1)) / sample;
    negRatio = sum(ismember(inMat, 0)) / sample;
    Entropy = -posRatio*log2(posRatio) - negRatio * log2(negRatio);


OUT = Entropy;

end