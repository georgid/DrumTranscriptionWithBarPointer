
%%%%   1 is base drum, 2 is snare, 3 is drum with
%%%%  snare in the same time.  4 is none. HARD CODED!
% featureVectorsBaseDrum, featureVectorsSnare, featureVectorsSnareWithBase,
% featureVectorsNone
function [featureVectorsGrouped]  = getDrumFeaturesForASong(songURI, numDrumTypes, doMovingMedian, doNorm )

addpath('../eval');
addpath('eval');
addpath('..');

% test: 
% songURI='/Users/joro/Documents/Linz/drumsbBarModel/AIST.RWC-MDB-P-2001.SMF_SYNC/RM -P001.SMF_SYNC.MID.parts.notePart.combined.snareDrum';
% songURI='/Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/accompaniment_all_drummers/drummer_2_116_minus-one_rock-60s_sticks';


% load all feature Vectors 
[featureVectors timeStampsForFeatureVectors ] = getFeaturesAndTimestamps( songURI, doMovingMedian, doNorm );

% result. features grouped by extension
featureVectorsGrouped = cell(numDrumTypes,1);


%%%%%% divide annotation into the drum types: 
% awk '{ if ($2=="bd") print $1}' ${file}.txt.combined  > ${file}.txt.combined.bd
% awk '{ if ($2=="sd") print $1}' ${file}.txt.combined  > ${file}.txt.combined.sd
% awk '{ if ($2=="bd_sd" || $2=="sd_bd" ) print $1}' ${file}.txt.combined  > ${file}.txt.combined.bd_sd


% read drum Ts from annotation

extensions = {'.txt.combined.bd', '.txt.combined.sd', '.txt.combined.bd_sd'};

for groupType = 1:numDrumTypes-1

	
annotSongURI = [ songURI extensions{groupType}];



	[sizeAnnotation, drumTimeStamps] = loadAnnotationTs(songURI, extensions{groupType});


	
	% get the relevant feature vectors
	if sizeAnnotation == 0
		indicesDrumTs = [];
	else
		indicesDrumTs = getIndicesDrumFeatures(drumTimeStamps, timeStampsForFeatureVectors);
	end
	
	featureVectorsGrouped{groupType} = [];
	for i= 1:size(indicesDrumTs,2)
		
		% if annotation is too a couple of miliseconds arelier than actual
		% onset, then spectral flux is close to zero. In this case take
		% next frame with index indicesDrumTs(i)+1. Check by sum of
		% magnitude of  feature
		
		if 	indicesDrumTs(i)+1 <= size(featureVectors,2)
            if  ( sum(featureVectors(:,indicesDrumTs(i)+1 )) <= sum(featureVectors(:,indicesDrumTs(i) ) ) )
                currFeature = featureVectors(:,indicesDrumTs(i) );

            else
                currFeature  = featureVectors(:,indicesDrumTs(i)+1 );
             
            end
        end
        
        featureVectorsGrouped{groupType} =	[ featureVectorsGrouped{groupType} currFeature ];
		
		
	end
end

%TODO: 
featureVectorsGrouped{numDrumTypes} = getFeaturesAndTimestamps( [songURI '_acc' ], doMovingMedian, doNorm  ); 

end