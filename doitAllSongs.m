% testPath = '/Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/accompaniment_all_drummers_test/';
% testPath = '/Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/accompaniment_all_drummers_test_2fold/';
% 
% testPath = '/Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/accompaniment_all_drummers_test_3fold/';

% allAggregFeatureVectors = doitAllSongs (testPath, 1, 0, 0)

function allAggregFeatureVectors = doitAllSongs (testPath, whichFold, gmm, doMovingMedian, doNorm)


dbPath2 = fullfile(testPath , '*.txt');
S = struct2cell(dir(dbPath2));
dbFileNames = S(1,:);

sizeDb = length(dbFileNames);


allAggregFeatureVectors=[];

for j = 1 : sizeDb

		songName = strtok(dbFileNames{j} , '.');

	disp(songName); 
	
		 
    aggregFeatureVectorsTestSong = doitOneSong(songName, testPath,gmm, whichFold, doMovingMedian, doNorm);
    allAggregFeatureVectors = [ allAggregFeatureVectors aggregFeatureVectorsTestSong ];		 

end


% songURI = [testPath 'drummer_2_116_minus-one_rock-60s_sticks'];
% 
% songURI= [testPath 'drummer_3_134_minus-one_bossa_sticks'];
% 
% songURI= [testPath 'drummer_3_126_minus-one_salsa_sticks'];

% songURI = [testPath 'drummer_1_114_minus-one_celtic-rock_brushes'];
% songURI = [testPath 'drummer_2_115_minus-one_salsa_sticks'];

end



