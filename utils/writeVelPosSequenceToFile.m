function writeVelPosSequenceToFile(a , sequence  )


 fid = fopen( a ,'w');
for i = 1:length(sequence)
 
	ts = getTsForGivenFrameNum(i);
	
		   fprintf(fid, '%.3f', ts );
      fprintf(fid,' %d' , sequence(i));
     
	
         fprintf(fid,'\n')
  
end
fclose(fid);
 



end