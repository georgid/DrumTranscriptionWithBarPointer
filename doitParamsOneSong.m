
path1 = '/Users/joro/Documents/Linz/drumsbBarModel/barmodelMIDIPositions/mean/';
path1Viterbi =  '/Users/joro/Documents/Linz/drumsbBarModel/barmodelMIDIPositions/meanVITERBI/';

path1 = path1Viterbi;

paths = {path1, '/home/user/norm/', '/home/user/mean+norm/', '/home/user/nomean+nonorm/'};



trainPaths = { [path1 'accompaniment_all_drummers_train/'],  ...
	[ path1 'accompaniment_all_drummers_train_2fold/' ] , ...
	[path1 'accompaniment_all_drummers_train_3fold/'] };


fold = 3; 
gmmFileName = [trainPaths{fold} 'gmm_fold' int2str(fold) '.mat'];
    load(gmmFileName);

	songName = 'drummer_2_120_minus-one_funk_sticks';
% 	songName = 'drummer_3_130_minus-one_funky_sticks';
	
	testPath = [path1 'accompaniment_all_drummers_test_3fold/'];
	whichFold = fold; 
	
	 doMovingMedian = 1;
	 doNorm = 0;
	 
	 aggregFeatureVectorsTestSong = doitOneSong(songName, testPath,gmm, whichFold, doMovingMedian, doNorm);