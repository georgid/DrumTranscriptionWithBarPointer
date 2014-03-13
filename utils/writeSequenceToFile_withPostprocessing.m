% parsing of  decoded Drum sequence and write its TimeStamps it to file. 
function writeSequenceToFile_withPostprocessing(decodedDrumTypeSequence, songURI)

%TODO. why repetition occurs. Time smoothing of results

sd = [songURI '.transcr.sd'];

bd = [songURI '.transcr.bd'];

bd_sd = [songURI '.transcr.bd_sd'];
 
 fidSd = fopen( sd ,'w');
  fidBd = fopen( bd ,'w');
fidBd_Sd = fopen( bd_sd ,'w');
 



addpath('utils');



for i=1:size(decodedDrumTypeSequence,1)

	if decodedDrumTypeSequence(i) ~= 4
		ts = getTsForGivenFrameNum(i);
		
		switch decodedDrumTypeSequence(i) 
			case 1
			whichFile=fidBd; 	
				
			case 2 
			whichFile=fidSd;
			
			case 3
			whichFile=fidBd_Sd;
			
		end
		
		% postprocess sequence. If 2 consequtive drumType frames (or over 2 frames) ->
				% consider only the second

			
		% special case last two frames. do not touch them. TODO they should
		% not be a special case ? 
			if (  (size(decodedDrumTypeSequence,1) - i) <= 1 ) 
			
				fprintf(whichFile, '%.3f', ts );
					fprintf(whichFile,'\n');

			% check for consecutive
				else	if (decodedDrumTypeSequence(i) ~= decodedDrumTypeSequence(i+1) && ...
							decodedDrumTypeSequence(i) ~= decodedDrumTypeSequence(i+2) )
							fprintf(whichFile, '%.3f', ts );
							fprintf(whichFile,'\n');

						end
			end

		
	end	

end

fclose(fidSd);
fclose(fidBd);
fclose(fidBd_Sd);


end