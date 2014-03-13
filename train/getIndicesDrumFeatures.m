%%%%%%%%%%% 
%%%%%% @goal : get indices of timestamps of annotated drums take one frame
%%%%%% per drum event
%%%% @algorithm: loop through each bar position. increment ts  

function indicesDrumTs = getIndicesDrumFeatures(drumTimeStamps, timeStamps)


% @param drumTimeStamps - timestamps of drums from annotation. 

% @param timeStamps - feature vector series and timestamps
% featureVectors ;


%%%%% divide feature vectors into bars


countDrumTs = size(drumTimeStamps,1);

% init
currDrumTs = drumTimeStamps(1);
indexTs = 1;
currTs = timeStamps(indexTs);


%result ts 
indicesDrumTs = [];

for drumTsNumber = 1:countDrumTs 
    
    while  currTs < currDrumTs
        indexTs = indexTs + 1;

		%         TODO: repair this workaround
		if (indexTs <= size(timeStamps) )
			currTs = timeStamps(indexTs);
		else
			currTs = timeStamps(indexTs-1) + 0.01;
		end

	end
    
	% 
    % mark begin Ts for one frame only
    indicesDrumTs = [indicesDrumTs indexTs];
% 	indicesDrumTs = [indicesDrumTs indexTs+1];
    
    % update rule for next iteration.  if used for security 
    if (drumTsNumber ~= countDrumTs)
    currDrumTs = drumTimeStamps(drumTsNumber + 1);
    end
    
end
    


end