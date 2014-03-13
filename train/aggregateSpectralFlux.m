% aggregates multiflux feature into 5 spectral bands.  
% band limits calculated by script drumBarsModel/getFrequencybandsForSpectralFlux.py 
% NOTE: the limits of band components HARDCODED.
% param - drumTypeFlux. size(numVectors, 5)

function aggregDrumTypeFlux = aggregateSpectralFlux(drumTypeFlux)
aggregDrumTypeFlux = zeros( size(drumTypeFlux,1) , 5 );

	%%%%% sum over spectral ranges: 

	% 28-180 hz
	aggregDrumTypeFlux(:,1) = sum(drumTypeFlux(:,1:6),2);  
	% 180-400 Hz
	aggregDrumTypeFlux(:,2) = sum(drumTypeFlux(:,7:16),2);  
	% 400-1000 Hz
	aggregDrumTypeFlux(:,3) = sum(drumTypeFlux(:,17:32),2);  
	% 1-8 kHz,
	aggregDrumTypeFlux(:,4) = sum(drumTypeFlux(:,33:68),2);  
	% 8-16 kHz
	aggregDrumTypeFlux(:,5) = sum(drumTypeFlux(:,69:81),2);  
end