[ allfeaturesGrouped gmm ] = traindoit(trainPaths{fold}, fold);

snare= allfeaturesGrouped{2};
bass = allfeaturesGrouped{1}; 

dlmwrite('features', vertcat(snare',bass'));
dlmwrite('lables', vertcat(ones(size(snare,2),1), 2*ones(size(bass),2), 1) );