function [prec, recall] = evalPrecRecallForOneSong(songURI)

countInserted= zeros(2,1) ;
countMissed = zeros(2,1) ;
countTranscribed = zeros(2,1) ;
countAnnotation = zeros(2,1) ;

	 [countInserted, countMissed, countTranscribed, countAnnotation] =  getCountInsertedAndMissedForOneSong(songURI, countInserted, countMissed, countTranscribed, countAnnotation);	

	 
		 
	prec =   (countTranscribed - countInserted) ./  countTranscribed;
	 
	 
	recall = (countAnnotation - countMissed) ./  countAnnotation;
 
	
	for drumType = 1:2
	
	 if (countTranscribed(drumType,1) == 0)
	 prec(drumType,1) = 1; 
	 end
	 
	 if countAnnotation(drumType,1) == 0
		recall(drumType,1) = 1; 
	 end
	 
	end






 

end
