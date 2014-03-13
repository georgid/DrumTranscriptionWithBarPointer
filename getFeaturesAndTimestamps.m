%%% extracts features and calculates timestamps for a given song
% songURI 
function [aggrSpectralFlux timeStampsFeatureVectors ] = getFeaturesAndTimestamps(songURI, doMedianfilter, doNorm)

addpath('train');


%%%%% extract SpectralFlux

commandGetSpectraFlux = sprintf ('python /Users/joro/Documents/Linz/RHYTHMIC_14March/RHYTHMIC/onset_program_multiband.py %s -s -v', [songURI '.wav']);
[status, result]= system(commandGetSpectraFlux);
if status ~= 0
	disp(sprintf('error while calling getFlux script on file %s', songURI)); 
end

%%% example extraction script: 
%  python /Users/joro/Documents/Linz/RHYTHMIC_14March/RHYTHMIC/onset_program_multiband.py /Users/joro/Documents/Linz/RHYTHMIC_14March/beat_anotated_data/train11.wav -s



% load feature Vectors from file 
songFeaturesFileName = strcat(songURI,'.onsets.multiflux');

featureVectorsT = dlmread(songFeaturesFileName);
 
numFeatureVectors = size(featureVectorsT,1);
 



 %%%%%%%%%%%%%% postprocess features. Summation. moving median and normalization. 
 
 % sumation in 5 bands
aggrSpectralFlux = aggregateSpectralFlux(featureVectorsT);
 
	sizeNorm = 100;


 % moving median
 
 if (doMedianfilter)
	for i=1:size(aggrSpectralFlux,2)
		
	 filteredAggrSpectralFlux = moving(aggrSpectralFlux(:,i), sizeNorm);
		
	 % fill the begininng and ends with last non-Nan value
	 filteredAggrSpectralFlux(1:sizeNorm/2) = filteredAggrSpectralFlux(sizeNorm/2 +1);
	 	 filteredAggrSpectralFlux(end-sizeNorm/2+1:end) = filteredAggrSpectralFlux(end - sizeNorm/2);

	 aggrSpectralFlux(:,i) =  aggrSpectralFlux(:,i) - filteredAggrSpectralFlux;
	 
	end
	
 
 end 
 
 % normalization

 if (doNorm)

	 for i=1:size(aggrSpectralFlux,2)
		tmpspectralFluxComponenet = aggrSpectralFlux(:,i);
	 maxAggrSpectralFlux = moving(tmpspectralFluxComponenet, sizeNorm, @(tmpspectralFluxComponenet )max(tmpspectralFluxComponenet ));
		
	
	 aggrSpectralFlux(:,i) =  aggrSpectralFlux(:,i) ./ maxAggrSpectralFlux;
	 
	end
	
 
 end 
 
 
 
 
 % transpose 
 aggrSpectralFlux = aggrSpectralFlux';
 
 
 
 
 
 
 
 
%%%%%%%%%%%%%%%%%%%%%%% getTs
addpath('utils');

addpath('../utils');

timeStampsFeatureVectors = [];
for i=1:numFeatureVectors
	timeStampsFeatureVectors = [timeStampsFeatureVectors; getTsForGivenFrameNum(i)  ]; 
end


end