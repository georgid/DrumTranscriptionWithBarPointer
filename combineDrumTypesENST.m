% 
% loads all events and combinations of events. 
% Combination is done based on a adjacency of 10 ms. 
%
% REFerences: in training used for timestamps of classes: 

% @input: *.txt
% @output : *.combined.txt - writes to file. 
% use awk script to divide annotation according to event type. 
% 
% NOTE: does same as mergeDrumTypesENST but for anevent within combination window
% instead of one sd and one bd event with same timestamp, prints one
% comined event bd_sd
%

function [timeStampsAllTypes eventTypeMatrixCombined] = combineDrumTypesENST(songURI)



%%%%%%%%%%%%%%%%%%%%%%%%%%% @params
combinationWindow = 0.010; 


%%%%%%%%%%%%%%% step 1. get only the sd and bd events

songAnnotationsFileName = [songURI  '.txt']; 
[timeStamps eventTypes] = loadAnnotations(songAnnotationsFileName);


%%%%%%%%%%%%% step 2. combine

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

       
       if strcmp(eventTypeFirst, secondEventType)
       % leave second event eventTypes(tsIndex)  as it is
	   else           
         eventTypes{tsIndex} = [eventTypeFirst '_' secondEventType];  
       end
       
       
   else
       
       % ADD an event
       timeStampsAllTypes = [timeStampsAllTypes; firstTimeStamp ] ;
       
       eventTypeMatrixCombined =  [eventTypeMatrixCombined; eventTypeFirst];
   end
   
      
end

% ADD last event
timeStampsAllTypes = [timeStampsAllTypes; timeStamps(end) ] ;

eventTypeMatrixCombined =  [ eventTypeMatrixCombined; eventTypes{end}];



%%%%%%%%% write to file
addpath('../utils');
addpath('utils');


a = [songAnnotationsFileName '.combined'];
 
 writeToFile( a , eventTypeMatrixCombined, timeStampsAllTypes );








end