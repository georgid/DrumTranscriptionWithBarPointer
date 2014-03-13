
% decodes the drum type. 
% returns index of prob.with highest prob. 
function [ currC, backPointerV, backPointerP, currDrumTypeIndexMaxProb ] = decodeViterbi(prevC, transMatrixFull, tableObsProbs, whichFrame, positionalProbs, V,P)

currDrumTypeIndexMaxProb  = zeros(P,1);

D = size(tableObsProbs,1);

	% pointer to prev. V state 
	backPointerV = zeros(V,P);
	% pointer to prec. P state
	backPointerP = zeros(V,P);

% instead of A table use initial probs 
if (whichFrame == 1)
	A = zeros(V,P);

	% demo: possible to start at only first 8 positions and all possible
	% velocities
	A(:,1:P) = 1/(P*V);


else 
	%create table A
	[A, backPointerV, backPointerP]  = calcATableViterbi(prevC, transMatrixFull);
end

%create table B
B = calcBTable(tableObsProbs, whichFrame, positionalProbs);



%%%%%%%%%%% calc curr table C
currC = zeros(V,P);

for p=1:P
	for v=1:V
		% The contributional prob: B(:,p) - for 4 drum types at a given
		% position
		currC(v,p) = sum( B(:,p) .* A(v,p) );
		
	end
	[probDummy currDrumTypeIndexMaxProb(p) ] = max(B(:,p));
end

% here normalize currC
currC = normalize(currC);

% check 
% if any(any(currC))
% 	disp(fprintf('C is all zeros at iteration (frame): %d \n', whichFrame));
% end





end



% normalization for a matrix of probs. 

function probsMatrix = normalize(probsMatrix)

totalSumProbs = sum( sum ( probsMatrix ) );
probsMatrix = probsMatrix/totalSumProbs;

end