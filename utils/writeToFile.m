function writeToFile( a , eventTypeMatrixCombined, timeStampsAllTypes  )


 fid = fopen( a ,'w');
for i = 1:size(eventTypeMatrixCombined,1)
  
	
		   fprintf(fid, '%.2f', timeStampsAllTypes(i) );
      fprintf(fid,' %s',eventTypeMatrixCombined{i});
     
	
         fprintf(fid,'\n')
  
end
fclose(fid);
 




end

