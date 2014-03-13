% C is table with Maximaml state sequence till given time frame t
function [mostProbVel mostProbPos mostProbDrumType]  = decodeAlgorithmViterbi( transMatrixFull, tableObsProbs, positionalProbs, V, P)


% tableObsProbs = tableObsProbs(:,1:100);

% dummy for first frame
prevC = [];


% results: 
numFeatureVectors = size(tableObsProbs,2);


allBackpointersToPrevV = zeros(numFeatureVectors, V,P );
allBackpointersToPrevP = zeros(numFeatureVectors, V,P );

% stores index of most prob drum type for a given state
indexDrumTypeMaxProb = zeros(numFeatureVectors, P );


%%%%%%%%% decoding
for whichFrame =1:numFeatureVectors
	
 	disp(fprintf('at iteration (frame) %d', whichFrame));

	[ currC, allBackpointersToPrevV(whichFrame,:,:), allBackpointersToPrevP(whichFrame,:,:), indexDrumTypeMaxProb(whichFrame,:) ] = ...
	decodeViterbi(prevC, transMatrixFull, tableObsProbs, whichFrame, positionalProbs, V,P);
 	
	prevC = currC;
 	



end

%%% BACKTRACKINGs

% mostProbDrumType = zeros(numFeatureVectors,1);

mostProbVel = zeros(numFeatureVectors,1);
mostProbPos = zeros(numFeatureVectors,1);


%%%%%% get most probable position and velocity state: 

% last state
[val, index ] = max(currC(:));
[mostProbVel(numFeatureVectors), mostProbPos(numFeatureVectors)] = ind2sub(size(currC),index);

% backtracking
for i=numFeatureVectors:-1:2

	currMostProbVel =  mostProbVel(i);
	currMostProbPos = mostProbPos(i);
	prevVel = allBackpointersToPrevV (i, currMostProbVel, currMostProbPos );	
	prevPos = allBackpointersToPrevP (i, currMostProbVel, currMostProbPos );
	
	mostProbVel(i-1) = prevVel;
	mostProbPos(i-1) = prevPos;
end


mostProbDrumType = zeros(numFeatureVectors,1);




% calc contrib prob for drum type using only the decoded mostProbPos

%%%
for j=1:numFeatureVectors 
	mostProbDrumType(j) = indexDrumTypeMaxProb(j,mostProbPos(j));
end




end
