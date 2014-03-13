
%%%%  numDrumType is of not use. 1 is base drum, 2 is snare, 3 is drum with
%%%%  snare in the same time.  4 is none
%%% !!!! HARD CODED !!!!
function positionalProbs = trainPositionalProbs(numDrumTypes, numPositions)


%%%%%%%%%%%%%%% combine all drum type events

 path = '/Users/joro/Documents/Linz/drumsbBarModel/AIST.RWC-MDB-P-2001.SMF_SYNC/';


% dbPath2 = fullfile(path , '*.MID.parts.notePart.snare+baseDrum');
% S = struct2cell(dir(dbPath2));
% dbFileNames = S(1,:);
% 
% sizeDb = length(dbFileNames);
% 
% 
% 
% %%% for each song DO:
% 
% % result
% allFeaturesGroupedIntoBarPos = [];
% 
% 	for j = 1 : sizeDb
% 
% 		songName = strtok(dbFileNames{j} , '.');
% 		songName = [songName '.SMF_SYNC.MID.parts'];
% 
% 
% 		 songURI = fullfile(path, songName);
% 		 combineDrumTypes(songURI);
% 		 
% 	end
% 	

	
	
%%%%%% scripts to run. extract positional probs

% get bar positions base drum and snare
% masterScript.doPositionalCounts.sh
% result: ${file}.barPos.${drumType}


% get all 4/4 bars
% masterScript.getTotalNumBars.sh
% result: NumAll44Bars

% total counts for all bar nums
% for i in `ls *.NumAllnon44Bars` ; do cat $i >>all.num44bars; done
% result: all.num44bars



% total counts for 2 drum types 
% for i in `ls *.barPos.baseDrum` ; do cat $i >>all.barPos.baseDrum; done;
% result: all.barPos.${drumType}


% get histogram one file
% baseDrumBarPos = dlmread([path 'RM-P001.SMF_SYNC.MID.parts.barPos.baseDrum'] );

%get counts all 
baseDrumBarPos = dlmread([path 'all.barPos.baseDrum']);
snareDrumBarPos = dlmread([path 'all.barPos.snareDrum']);
snareWithBaseDrumBarPos = dlmread([path 'all.barPos.snareWithBaseDrum']);

numsAll44Bars = dlmread([path 'all.num44bars']);
totalCountAll44Bars = sum(numsAll44Bars);

% numsAllBars = dlmread([path 'all.numBars']);
% totalCountAllBars = sum(numsAllBars);

%%%%%%%%%% pool over each 16 target positions
numPositionsToExtract = numPositions / 16; 

% only 4/4 metrum considered
binSize = 4/numPositionsToExtract;


[nelementsBaseDrum, xcentersBaseDrum] = makeHistogram(baseDrumBarPos, binSize);

[nelementsSnareDrum, xcentersSnareDrum] = makeHistogram(snareDrumBarPos, binSize);

[nelementsSnareWithBaseDrum, xcenterSnareWithBaseDrum] = makeHistogram(snareWithBaseDrumBarPos, binSize);




%result 
positionalProbs = ones(numDrumTypes, numPositions);

barsBass = nelementsBaseDrum / totalCountAll44Bars;
positionalProbs(1,:) = multiplyArrayNTimes(barsBass,16);

barsSnare = nelementsSnareDrum / totalCountAll44Bars; 
positionalProbs(2,:) = multiplyArrayNTimes(barsSnare,16);

barsSnareWithBaseDrum =  nelementsSnareWithBaseDrum / totalCountAll44Bars;
positionalProbs(3,:) = multiplyArrayNTimes(barsSnareWithBaseDrum,16); 

positionalProbs(4,:) = 1 - positionalProbs(1,:) - positionalProbs(2,:) - positionalProbs(3,:); 


% figures
%  figure; bar(xcentersBaseDrum + 1, positionalProbs(1,:));
%  figure; bar(xcentersSnareDrum + 1, positionalProbs(2,:));
%  figure; bar(xcentersBaseDrum + 1, positionalProbs(3,:));



end


% make histogram for a drum type
function [nelements, xcenters] = makeHistogram(drumTypeBarPos, binSize)

[nelements,xcenters] = hist(drumTypeBarPos,0:binSize:4);

% last bin is actually first bin
nelements(1)=nelements(1)+nelements(end);

nelements=nelements(1:end-1);
xcenters= xcenters(1:end-1);

end

% replicates elements e.g. if n = 3 => [1 2 3]  -> [1 1 2 2 3 3]
function finalA = multiplyArrayNTimes(a,n)

finalA = [];
for i = 1:size(a,2)
b = repmat(a(i),1,n-1);
c= [a(i) b ];
finalA = [finalA c];
end

end
	
	
	
