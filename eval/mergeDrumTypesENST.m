% loads all events 
% Merges events of same type a adjacency of 25 ms. 
%
% @input: *.txt
% @output : *.txt.bd and *.txt.sd - writes to file 
function [timeStampsAllTypes eventTypeMatrixCombined] = mergeDrumTypesENST(songURI)




%%%%%%%%%%%%%%%%%%%%%%%%%%% @params
combinationWindow = 0.025; 


%%%%%%%%%%%%%%% step 1. get only the sd and bd events

songAnnotationsFileName = [songURI  '.txt']; 
[timeStamps eventTypes] = loadAnnotations(songAnnotationsFileName);


%%%%%%%%%%%%% step 2. merge

% output in two arrays
timeStampsAllTypes = [];

eventTypeMatrixCombined = {};


tsIndex = 1; 
while tsIndex < size(timeStamps,1)
   % find next event; check whether within combination window.
   
   firstTimeStamp = timeStamps(tsIndex);
   eventTypeFirst = eventTypes{tsIndex};
   
   tsIndex = tsIndex + 1; 
   secondTimeStamp =  timeStamps(tsIndex);
   secondEventType = eventTypes{tsIndex};
   
   % if within combination window
   if secondTimeStamp - firstTimeStamp <= combinationWindow
       timeStamps(tsIndex) = (firstTimeStamp + secondTimeStamp) / 2;

              % events of same type. leave second event eventTypes(tsIndex)  as it is
       if strcmp(eventTypeFirst, secondEventType)
		   
	   else    
		   % use this as  a way to mark this event
         eventTypes{tsIndex} = [eventTypeFirst '_' secondEventType];  
       end
       
       
   else
       
       % ADD an event
		[timeStampsAllTypes, eventTypeMatrixCombined] = addEvent(eventTypeFirst, firstTimeStamp, timeStampsAllTypes, eventTypeMatrixCombined);
	   
   end
   
      
end

% ADD last event

[timeStampsAllTypes, eventTypeMatrixCombined] = addEvent(eventTypes{end},  timeStamps(end), timeStampsAllTypes, eventTypeMatrixCombined);

%%%%%%%%% write to file
addpath('../utils');

a = [songAnnotationsFileName '.merged'];
 
 writeToFile( a , eventTypeMatrixCombined, timeStampsAllTypes )






end

