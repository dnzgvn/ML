function [humanAccuracy] = humanTest(dataX, dataY)



[m,n] = size(dataX);
currentLine = 1;
humanGuess = zeros(1);

while currentLine <= m
    
    xVis = dataX(currentLine,1:n/2);
    yVis = dataX(currentLine,(n/2)+1:end);
    clf;
    hold off;
    
    scatter(-xVis,-yVis);
    disp('________________________________');
    disp(strcat('Current guess: ', int2str(currentLine), '-out-of-' , int2str(m)));
    disp('select emotion: from the following:');
    disp('1 = anger');
    disp('2 = disgust');
    disp('3 = fear');
    disp('4 = happiness');
    disp('5 = sadness');
    disp('6 = surprise');
    humanGuess(currentLine) = input('?...')';
    disp(' ');
    disp('your guess was: ');
    if dataY(currentLine) == humanGuess(currentLine)
       disp('correct');
    else
       disp('not correct');
    end
    disp('   ');
    currentLine = currentLine + 1;
    
    
end

humanAccuracy = calcAccuracy(humanGuess, dataY);
disp('your guesses: ');
disp(humanGuess);
disp('Ground truth: ');
disp(dataY');
end


function accuracy = calcAccuracy (in1, in2)

binaryMatrix = zeros(1, length(in1));


    for x = 1:length(in1)
       if in1(x) == in2(x)
           binaryMatrix(x) = 1;        
       end
    end
    
accuracy = (sum(binaryMatrix)/length(in1)) * 100;

end