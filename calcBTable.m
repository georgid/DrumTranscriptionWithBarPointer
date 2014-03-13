% calcs B-table. Separate B for a given feature vector at time t.
% B=zeros(D,P);

function B = calcBTable(tableObsProbs, whichFrame, positionalProbs )

% @param tableObsProb  (drumType,currFV)
% @param positionalProbs (drumType, position)


% num drum types
D=size(positionalProbs,1);

P= size(positionalProbs,2);


B=zeros(D,P);

	for i=1:P
		B(:,i)= tableObsProbs(:,whichFrame) .* positionalProbs(:,i); 
	end


end