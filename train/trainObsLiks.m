%TRAINOBSLIKS builds models of observation liks
% @param pathToSongs - path of training dir

function [ aggregDrumTypeFlux gmm ] = trainObsLiks( path, doMovingMedian, doNorm )
addpath('..');

numDrumTypes = 4; 

%  path = '/Users/joro/Documents/Linz/RHYTHMIC_14March/AIST.RWC-MDB-P-2001.SMF_SYNC/';

%   path = '/Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/accompaniment_all_drummers';
 
dbPath2 = fullfile(path , '*.txt');
S = struct2cell(dir(dbPath2));
dbFileNames = S(1,:);

sizeDb = length(dbFileNames);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% get features of all files into frum type groups
%%% for each song DO:

% result
aggregDrumTypeFlux = cell(4,1);



for j = 1 : sizeDb

		songName = strtok(dbFileNames{j} , '.');

           % skip if song is MIDI
%    positionMIDI = strfind(songName,'MIDI'); 
%             
%             if ~isempty(positionMIDI);
%                 continue;
%             end
%         
	disp(songName); 
	
		 songURI = fullfile(path, songName);
% 	[timeStampsAllTypes eventTypeMatrixCombined] = 	 combineDrumTypesENST(songURI);
	
	% divide into types
 	featureVectorsGrouped = getDrumFeaturesForASong(songURI,numDrumTypes, doMovingMedian, doNorm);
	
	for drumType = 1:numDrumTypes	
	 	
	 aggregDrumTypeFlux{drumType} = [ aggregDrumTypeFlux{drumType} featureVectorsGrouped{drumType} ]; 
	end
	
	
end
	
%%%%%%% write persistently features into a file


%%%%%%%%%%%%% fit GMM for all drum types
numComponents = 2;

	% loop for drum types
	for d = 1:numDrumTypes


		tmpDrumTypeFlux = aggregDrumTypeFlux{d};

% 	 	figure; ksdensity(drumTypeFlux{d}(1,:)); 
% 		figure; ksdensity(drumTypeFlux{d}(2,:)); 
% 		figure; ksdensity(drumTypeFlux{d}(3,:)); 
% 		figure; ksdensity(drumTypeFlux{d}(4,:)); 
% 		figure; ksdensity(drumTypeFlux{d}(5,:)); 

		 % fit 2 components using EM
		 options = statset('Display','final');
		 
		tmpAggregDrumTypeFluxT = tmpDrumTypeFlux';
		
		%%%% non drum type has more components
		
		if (d == numDrumTypes)
			numComponents = 3;
				gmm{d} = gmdistribution.fit(tmpAggregDrumTypeFluxT, numComponents, 'Options', options, 'Regularize',0.3);
		
		else 
			
				gmm{d} = gmdistribution.fit(tmpAggregDrumTypeFluxT, numComponents, 'Options', options, 'Regularize',0.3);
		end

	end




 %%%%% visualize the 2 components
% %use the fit to cluster the data:
% idx = cluster(obj,aggregDrumTypeFluxT);
% cluster1 = aggregDrumTypeFluxT(idx == 1,:);
% cluster2 = aggregDrumTypeFluxT(idx == 2,:);
% 
% figure,
% hold on
% scatter(cluster1(:,1),cluster1(:,2),30,'r.')
% scatter(cluster2(:,1),cluster2(:,2),30,'g.')





end

