% calc a table for a song. can be reused on decoding
function tableObsProbs = calcTableObsProb(aggregFeatureVectors, gmm, D)



numFeatVectors = size(aggregFeatureVectors,2);

tableObsProbs = zeros (D, numFeatVectors ) ;

aggregFeatureVectorsT = aggregFeatureVectors';
	
	for d=1:D
		% used obs. posterior prob form trained model 
% 		tableObsProbs(d,f) = getObsProb(aggregFeatureVectors, gmm, d);
        obsProbsT =  pdf(gmm{d}, aggregFeatureVectorsT);
        tableObsProbs(d,:) = obsProbsT'; 
	end


end