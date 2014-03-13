
% @deprecated. parsing of  decoded Drum sequence and write its TimeStamps it to file. NO postprosessing
function writeSequenceToFile(decodedDrumTypeSequence, songURI)

%TODO. why repetition occurs. Time smoothing of results

sd = [songURI '.transcr.sd_old'];

bd = [songURI '.transcr.bd_old'];

bd_sd = [songURI '.transcr.bd_sd'];
 
 fidSd = fopen( sd ,'w');
  fidBd = fopen( bd ,'w');
fidBd_Sd = fopen( bd_sd ,'w');
 







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
		
		
					
							fprintf(whichFile, '%.3f', ts );
							fprintf(whichFile,'\n');

		

		
	end	

end

fclose(fidSd);
fclose(fidBd);
fclose(fidBd_Sd);


end