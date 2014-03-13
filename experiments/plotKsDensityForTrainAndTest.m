
cd '/home/user/BarModelMidiBarPositions/train';



close all; 

fold = 3; 


addpath('train');

path = '/home/user/';
path = '//Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/';

trainPaths = { [path 'accompaniment_all_drummers_train/'],  ...
	[ path 'accompaniment_all_drummers_train_2fold/' ] , ...
	[path 'accompaniment_all_drummers_train_3fold/'] };


%%%% training set
trainFeaturesGrouped= allfeaturesGrouped;
doMovingMedian = 0;

[ trainFeaturesGrouped gmm ] = traindoit(trainPaths{fold}, fold, doMovingMedian);


 		figure; ksdensity(trainFeaturesGrouped{2}(2,:)); 
 		figure; ksdensity(trainFeaturesGrouped{2}(3,:)); 
 		figure; ksdensity(trainFeaturesGrouped{2}(4,:)); 

		
		
		

%%%%%%%%%%%%

% test set all songs

testPaths = { [path  '/accompaniment_all_drummers_test/'], ...
	[path  'accompaniment_all_drummers_test_2fold/'] , ...
	[path 'accompaniment_all_drummers_test_3fold/'] };



allAggrFV = doitAllSongs(testPaths{fold},fold);
    


 		figure; ksdensity(allAggrFV(2,:)); 
 		figure; ksdensity(allAggrFV(3,:)); 
 		figure; ksdensity(allAggrFV(4,:)); 


figure; 






%%%%%%%%%%%%%%%% test one song only
songName = 'drummer_3_131_minus-one_funk_sticks'; 

doMovingMedian = 1;

allAggrFV = doitOneSong(songName, testPaths{fold}, fold, doMovingMedian);
    
        figure; ksdensity(allAggrFV(2,:)); 
 		figure; ksdensity(allAggrFV(3,:)); 
 		figure; ksdensity(allAggrFV(4,:));




