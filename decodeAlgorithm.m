function [mostProbDrumType, mostProbVel, mostProbPos ] = decodeAlgorithm( transMatrixFull, tableObsProbs, positionalProbs, V, P)
% dummy for first frame
prevC = [];


% results: 
numFeatureVectors = size(tableObsProbs,2);
mostProbDrumType = zeros(numFeatureVectors,1);
mostProbVel = zeros(numFeatureVectors,1);
mostProbPos = zeros(numFeatureVectors,1);

%%%%%%%%% decoding
for whichFrame =1:numFeatureVectors
	
	disp(fprintf('at iteration (frame) %d', whichFrame));
	[mostProbDrumType(whichFrame), mostProbVel(whichFrame), mostProbPos(whichFrame),  currC ] =...
		decode(prevC, transMatrixFull, tableObsProbs, whichFrame, positionalProbs, V, P);
	
	prevC = currC;
	
	disp(fprintf('\n most probable position: %d \n most probable velocity: %d \n most probable drum : %d \n' , ...
		mostProbPos(whichFrame), mostProbVel(whichFrame), mostProbDrumType(whichFrame) ) );
	
	save('decodedDrumSequence','mostProbDrumType');
	
	
end