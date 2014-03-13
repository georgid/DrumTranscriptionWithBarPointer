% TODO: use DTW to find best alignment 
% algorithm: for each annotation find closest match (timestamp) in transcr.
% use each trascr timestamp only once. 
function [countInserted, countMissed] = calcMissesAndInserts(annotationTs, transcriptionTs)

% +- tolerance in seconds
toleranceTimeWindow = 0.03;


countMissed = 0;
countInserted = 0;

% find a match for each from annotation
for whichTs = 1:size(annotationTs,1)

	 [isElementOf, index]  =  getClosestTs(annotationTs(whichTs,1), transcriptionTs, toleranceTimeWindow);
	 
	 % matched
	 if (isElementOf)  
        
		
 		% throw away used transcr 
			transcriptionTs(index) = []; 
	 else
        
        %     false negative (missed)
		countMissed = countMissed + 1;
        
	 end
	  
	 
end

% inserted are these from transcr. which do not correpond to annotation
countInserted = size(transcriptionTs,1);




end

%%%%%%% finds the entry with closest Timestamp to query entry witihn some window 
function [exists, index] = getClosestTs(queryEntry, targetArray, toleranceTimeWindow)
    index = 0;
	
	
	if isempty(targetArray) 
	exists = 0;
	
	% compare. 
	else
		[minTimeDist index ] =  min(abs(targetArray - queryEntry ) );
		exists = 1; 

		if minTimeDist > toleranceTimeWindow;
			exists = 0; 

		end

	end
	
end
