%%%
% writes only bar begin ts-> e.g. frames where the signal is restarted
%
%
function writeBarBeginsToFile(a , sequence  )


 fid = fopen( a ,'w');

 ts = getTsForGivenFrameNum(1);
	   fprintf(fid, '%.3f', ts );
      fprintf(fid,' %d' , sequence(1));	
	           fprintf(fid,'\n')

 
 for i = 2:length(sequence)
 
	ts = getTsForGivenFrameNum(i);
	
	
	if (sequence(i) < sequence(i-1))
		   fprintf(fid, '%.3f', ts );
      fprintf(fid,' %d' , sequence(i));
	           fprintf(fid,'\n')

     
	end
	
  
 end
fclose(fid);
 



end