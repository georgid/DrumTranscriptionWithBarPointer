% decodes the drum type. 
% returns index of prob.with highest prob. 
function [indexMostProbDrumType, mostProbVel, mostProbPos, currC ] = decode(prevC, transMatrixFull, tableObsProbs, whichFrame, positionalProbs, V,P)

D = size(tableObsProbs,1);

% instead of A table use initial probs 

if (whichFrame == 1)
	A = zeros(V,P);

	% demo: only first 8 probs. 
	A(:,1:8) = 1/(8*V);

else 
	%create table A
	A = calcATable(prevC, transMatrixFull);
end

%create table B
B = calcBTable(tableObsProbs, whichFrame, positionalProbs);



%%%%%%%%%%% calc curr table C
currC = zeros(V,P);

for v=1:V
	for p=1:P
		currC(v,p)= sum( B(:,p) .* A(v,p) );
	end
end

% here normalize currC
currC = normalize(currC);

% check 
% if any(any(currC))
% 	disp(fprintf('C is all zeros at iteration (frame): %d \n', whichFrame));
% end


%%% get most probable position and velocity state: 
[val, index ] = max(currC(:));
[mostProbVel,mostProbPos] = ind2sub(size(currC),index);



%%%%%%%%%% calc contributional probs. 

% sum over dimension of velocities. This gives weights of states of positions
% \sum_{v_{t}}A(toV,toP)
positionalWeights = sum(A);

% final drum type contributional probabilities. sum over positions
contributionalProbs = positionalWeights * B(:,:)'; 

%%% slower but more intuitive way for the previous operation
for d= 1 : D
	contributionalProbs(d) = B(d,:) * positionalWeights';
end


% take max over p instead of sum.
% for d= 1 : D
% 	a = B(d,:) .* positionalWeights;
% 	contributionalProbs(d) = max(a,2);
% end


[blah, indexMostProbDrumType] = max(contributionalProbs);

end



% normalization for a matrix of probs. 

function probsMatrix = normalize(probsMatrix)

totalSumProbs = sum( sum ( probsMatrix ) );
probsMatrix = probsMatrix/totalSumProbs;

end