% if marked event, then do two events 
function [timeStampsAllTypes, eventTypeMatrixCombined] = addEvent(eventTypeFirst, firstTimeStamp, timeStampsAllTypes, eventTypeMatrixCombined)

	% events of same type 
 if  isempty ( strfind(eventTypeFirst, '_') ) 
	
	 timeStampsAllTypes = [timeStampsAllTypes; firstTimeStamp ] ;
       
       eventTypeMatrixCombined =  [eventTypeMatrixCombined; eventTypeFirst];

 else
	 % two events : HARD CODED: sd abd bd
	   timeStampsAllTypes = [timeStampsAllTypes; firstTimeStamp ] ;
       
       eventTypeMatrixCombined =  [eventTypeMatrixCombined; 'bd'];
	   
	   
	   timeStampsAllTypes = [timeStampsAllTypes; firstTimeStamp ] ;
       
       eventTypeMatrixCombined =  [eventTypeMatrixCombined; 'sd'];
	   
	   
      
 end
 
 
	 
 end