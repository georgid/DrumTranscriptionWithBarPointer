
function  [countInserted, countMissed, countTranscribed, countAnnotation] =  getCountInsertedAndMissedForOneSong(songURI, countInserted, countMissed, countTranscribed, countAnnotation)

%%%%% bd and sd
% 	drumTypeExt = {'bd', 'sd', 'bd_sd'};
	drumTypeExt = {'bd', 'sd'};
	for drumType = 1:2
	
		% load annotations 
		suffixDrumType =  [ '.txt.merged.' drumTypeExt{drumType} ]; 
	[sizeAnnotation, annotationTs] = loadAnnotationTs(songURI, suffixDrumType);

		% load transcription
		 suffixDrumTranscr  = ['.transcr.' drumTypeExt{drumType}];
			[sizeTranscription, transcriptionTs] = loadAnnotationTs(songURI, suffixDrumTranscr);


		[tmpCountInserted, tmpCountMissed] = calcMissesAndInserts(annotationTs, transcriptionTs);
		
		% bd or sd
%  		if (drumType ~= 3)
			countInserted(drumType,1) = countInserted(drumType,1) + tmpCountInserted;
			countMissed(drumType,1) = countMissed(drumType,1) + tmpCountMissed;
			countTranscribed(drumType,1) = countTranscribed(drumType,1) + sizeTranscription;
			countAnnotation(drumType,1)  = countAnnotation(drumType,1) + sizeAnnotation;
		% bd_sd considerd as event of type bd once and as sd once more
% 		else 
% 			countInserted(:,1) = countInserted(:,1) + tmpCountInserted;
% 			countMissed(:,1) = countMissed(:,1) + tmpCountMissed;
% 			countTranscribed(:,1) = countTranscribed(:,1) + sizeTranscription;
% 			countAnnotation(:,1)  = countAnnotation(:,1) + sizeAnnotation;
% 		end

	end 
	
	
end