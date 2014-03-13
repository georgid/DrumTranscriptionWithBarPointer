function barPosition  = getBarPositionsforPairs

% bar 1 
barBegins = dlmread('/Users/joro/Documents/Linz/drumsbBarModel/barmodelMIDIPositions/meanVITERBI/accompaniment_all_drummers_test_3fold/drummer_3_131_minus-one_funk_sticks.barBegins.selected');


drumTs = dlmread('/Users/joro/Documents/Linz/drumsbBarModel/barmodelMIDIPositions/mean/accompaniment_all_drummers_test_3fold/drummer_3_131_minus-one_funk_sticks.transcr.bd.selected.txt');

 
drumTsCounter = 1;

for bar=1:8

beginTs = barBegins(bar,1);
endTs = barBegins(bar+1,1);

currTs = drumTs(drumTsCounter);
counter=1;

	while (currTs <= endTs) && (drumTsCounter < size(drumTs,1))

		barPosition( bar, counter) = (currTs - beginTs) / ((endTs - beginTs) /32);

		counter = counter +1; 
		drumTsCounter = drumTsCounter + 1;
		
		currTs = drumTs(drumTsCounter);


	end



end % end bar

end

% put ones on diag.
% for i = 1:8 result(i,i) =1;  end