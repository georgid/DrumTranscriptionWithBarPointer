

%%%%%%
% for all songs in given path count inserts, misses and so on. 
% then at the end count eval
%%%


function [prec, recall] = evalPrecRecallForAllsongs(testPath)



dbPath2 = fullfile(testPath , '*.txt');
S = struct2cell(dir(dbPath2));
dbFileNames = S(1,:);
% 
%  dbFileNames = {'drummer_2_117_minus-one_metal_sticks' ...
%   ,'drummer_2_116_minus-one_rock-60s_sticks' };

sizeDb = length(dbFileNames);


%%%%% 1 is bd, 2 is sd
countInserted= zeros(2,1) ;
countMissed = zeros(2,1) ;
countTranscribed = zeros(2,1) ;
countAnnotation = zeros(2,1) ;


for j = 1 : sizeDb

		songName = strtok(dbFileNames{j} , '.');
        
        % skip if song is MIDI
%    positionMIDI = strfind(songName,'MIDI'); 
%             
%             if ~isempty(positionMIDI);
%                 continue;
%             end
            
			 songURI = fullfile(testPath, songName);
			
          
		disp(songURI); 
		

	 [countInserted, countMissed, countTranscribed, countAnnotation] =  getCountInsertedAndMissedForOneSong(songURI, countInserted, countMissed, countTranscribed, countAnnotation);	
		 

end






	prec =   (countTranscribed - countInserted) ./  countTranscribed;
	recall = (countAnnotation - countMissed) ./  countAnnotation;
 
	










 

end
