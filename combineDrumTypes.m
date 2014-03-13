% loads all events and combinations of events. 
% Combination is done based on a adjacency of 25 ms. 
%
% @input: *.MID.parts
% @output : *.MID.parts.notePart.combined - writes to file 
function [timeStampsAllTypes eventTypeMatrixCombined] = combineDrumTypes(songURI)

songAnnotationsFileName = [songURI  '.notePart.snare+baseDrum']; 

%%%%%%%%%%%%%%%%%%%%%%%%%%% @params
combinationWindow = 0.025; 

numEvents = 20; 



%%%%%% load as text file

fid = fopen(songAnnotationsFileName);

% Read numbers and string into a cell array
annotation = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');

% Then extract the numbers and strings into their own cell arrays
timeStamps = annotation{5};
eventTypeMatrix  = annotation{3};

% combine all into a matrix of size n x 25
MatrixMIDInotes = double(zeros(size(timeStamps,1), 15 ));

for i=1:15
MatrixMIDInotes(:,i) = annotation{i};
end


% output in two arrays
timeStampsAllTypes = [];

eventTypeMatrixCombined = [];





tsIndex = 1; 
while tsIndex < size(timeStamps,1)
   % find next event; check whether within combination window.
   
            firstMIDInote= MatrixMIDInotes(tsIndex,: );
   firstTimeStamp = firstMIDInote(5);
   firstEventType = firstMIDInote(3);
   
   tsIndex = tsIndex + 1; 
   secondMIDInote = MatrixMIDInotes(tsIndex,: ); 
   secondTimeStamp = secondMIDInote(5);
   secondEventType = secondMIDInote(3);
   
   % if within combination window
   if secondTimeStamp - firstTimeStamp <= combinationWindow
       MatrixMIDInotes(tsIndex,5) = (firstTimeStamp + secondTimeStamp) / 2;

       
       if  ( (firstEventType == 35 || firstEventType == 36) && (secondEventType == 38 || secondEventType == 40)  ) ||...
		   ( (firstEventType == 38 || firstEventType == 40) && (secondEventType == 35 || secondEventType == 36) )
			% 11 is code for both events
		            MatrixMIDInotes(tsIndex,3) = 11; 

       else
       % leave second event eventTypeMatrix(tsIndex)  as it is
           
       end
       
       
   else
       
       % ADD an event
       
       eventTypeMatrixCombined =  [eventTypeMatrixCombined; firstMIDInote];
   end
   
      
end

% ADD last event because it is not looped through

eventTypeMatrixCombined =  [ eventTypeMatrixCombined; MatrixMIDInotes(end,:)];


% write
songAnnotationsFileName = [songURI '.notePart.combined']; 
dlmwrite(songAnnotationsFileName, eventTypeMatrixCombined, 'delimiter', ' ');


fclose(fid);







end