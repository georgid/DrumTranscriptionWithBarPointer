% loads only the selected types of annotations. 
% type HARD CODED. sd and bd
function  [timeStamps eventTypes] = loadAnnotations(songAnnotationsFileName)



disp(songAnnotationsFileName);


%%%%%% load as text file

fid = fopen(songAnnotationsFileName);

% Read numbers and string into a cell array
annotation = textscan(fid, '%f %s');

% Then extract the numbers and strings into their own cell arrays
timeStampsOrig = annotation{1};
eventTypesOrig  = annotation{2};



% results with only bd and sd
timeStamps = [];
eventTypes = {};

for tsIndex = 1: size(timeStampsOrig,1)
	if (strcmp (eventTypesOrig{tsIndex}, 'bd') || strcmp (eventTypesOrig{tsIndex}, 'sd') )
		timeStamps = [timeStamps; timeStampsOrig(tsIndex) ];
		eventTypes = [eventTypes; eventTypesOrig{tsIndex} ];

	end

end


end