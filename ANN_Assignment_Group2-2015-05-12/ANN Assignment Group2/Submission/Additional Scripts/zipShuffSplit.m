function [shuffleX, shuffleY] = zipShuffSplit(in1, in2)

[m1, n1] = size(in1);  % define the sizes of the two input matrices
[m2, n2] = size(in2);

shuffleMat = zeros(m1, n1+n2);  % create a matrix to fill out with the two 
                                % sets of values, (x,y)

shuffleMat(1:m1, 1:n1) = in1(1:m1, 1:n1);  %fill in the shuffle matrix
shuffleMat(1:m1, n1+1:end) = in2(1:m2, 1:n2);

counter = m1;  % initialise a counter equal to the length of the input matrices

outMatrix = zeros(m1,n1+n2);  % initialise a counter equal to the shuffle matrix size

while counter > 0   %while the number of items in the output 
    index = (ceil(counter*rand()));  % select a random number in the range 
                                     % of the size of the shuffle matrix
    outMatrix(counter, : ) = shuffleMat(index, :);  %copy the row across 
                                                 % from shuffle to out matrix
    shuffleMat(index, :) = [];  %delete the previously copied row of the shuffle matrix
    counter = counter - 1;   %decrement the counter so that the random 
                            %number doesn't select a number out of range of
                            %the size of the counter
end

shuffleX = zeros(m1,n1);   %housekeeping stuff, an old engineering habit
ShuffleY = zeros(m2,n2);   %  - just copying values across into a new matrix
                           %  as I've found this occasionally catches
                           %  errors
shuffleX(1:m1, 1:n1) = outMatrix(1:m1, 1:n1);
shuffleY(1:m2, 1:n2) = outMatrix(1:m1, n1+1:end);

end
