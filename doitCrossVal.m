%doitAll
 
function [crossValidatedPrec, crossValidatedRecall] = doitCrossVal(pathData, doMovingMedian, doNorm)



 %%%%%  TRAIN! 3 folds
addpath('train');

% pathT = '/Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/';
% pathData = '/home/user/nomean+nonorm/';

numFolds = 3;


trainPaths = { [pathData 'accompaniment_all_drummers_train/'],  ...
	[ pathData 'accompaniment_all_drummers_train_2fold/' ] , ...
	[pathData 'accompaniment_all_drummers_train_3fold/'] };
% 
% for fold = 1:numFolds
% 
% 	[ trainFeaturesGrouped gmm ] = traindoit(trainPaths{fold}, fold, doMovingMedian, doNorm);
% 	   gmmFileName = [trainPaths{fold} 'gmm_fold' int2str(fold) '.mat'];
%     save(gmmFileName,'gmm' );
% end




% %%%%%%%%% DECODE 3 folds

testPaths = { [pathData  '/accompaniment_all_drummers_test/'], ...
	[pathData  'accompaniment_all_drummers_test_2fold/'] , ...
	[pathData 'accompaniment_all_drummers_test_3fold/'] };

for fold = 1:numFolds
    
      gmmFileName = [trainPaths{fold} 'gmm_fold' int2str(fold) '.mat'];
    load(gmmFileName);
    
     doitAllSongs (testPaths{fold}, fold, gmm, doMovingMedian, doNorm );

end




%%%%%% calc  total metrics all songs 3-fold cross validation
addpath('eval');

precTotal = zeros(2,1);
recallTotal = zeros(2,1);
 

for fold = 1:numFolds
[prec, recall] = evalPrecRecallForAllsongs(testPaths{fold});
precTotal = precTotal + prec;
recallTotal = recallTotal + recall;

end

crossValidatedPrec = precTotal / 3; 
crossValidatedRecall = recallTotal / 3; 

end
