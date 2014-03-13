%doit songURI is full path and song name
%%%
% Writes results to file
%
function [ aggregFeatureVectorsTestSong decodedDrumSequence decodedV decodedP ] = doitOneSong(songName, testPath, gmm, whichfold, doMovingMedian, doNorm)

%   test one file: 
% testPath = '/Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/accompaniment_all_drummers_test_2fold/';
% songName = 'drummer_2_116_minus-one_rock-60s_sticks';
% whichFold = 2; doMovingMedian = 0; doNorm = 0;
% aggregFeatureVectorsTestSong = doitOneSong(songName, testPath, whichFold, doMovingMedian, doNorm);

V=8;
P=512;
D=4; 

addpath('train');

addpath('utils');

 songURI = fullfile(testPath, songName);
 
%%%%%%% load trained models
% load 'allTraineingFeaturesGrouped.mat';


load 'transMatrixFull.mat';
load  'positionalProbs.mat';



[aggregFeatureVectorsTestSong timeStampsForFeatureVectors ] = getFeaturesAndTimestamps( songURI, doMovingMedian, doNorm );

% save('featureVectorsTestSong', 'featureVectorsTestSong');
% load 'featureVectorsTestSong';



%%%%%%% decoding preparation
% save('aggregFeatureVectorsTestSong', 'aggregFeatureVectorsTestSong');


tableObsProbName = ['tableObsProb' songName '_fold' int2str(whichfold) ];
tableObsProb = calcTableObsProb(aggregFeatureVectorsTestSong, gmm, D);

 save (tableObsProbName, 'tableObsProb');

%%%%%%%%%%%%%% decode: FILTERING
% [decodedDrumSequence, decodedV, decodedP] =  decodeAlgorithm( transMatrixFull, tableObsProb, positionalProbs, V, P);

 

 
%%%%%% HERE: VITERBI
 [decodedV decodedP decodedDrumSequence ] =  decodeAlgorithmViterbi( transMatrixFull, tableObsProb, positionalProbs, V, P);
% decodedDrumSequence = [];
%%%%%%%%%%%%%% END VITERBI



%  use only obs prob.
% decodedDrumSequence = max(tableObsProb);


 % store decoded drum sequence
    songFileName = [ songURI '_decodedDrumSeqViterbi' '.mat'];
    save(songFileName ,'decodedDrumSequence' );

	load( songFileName );

addpath('eval');

% writeSequenceToFile(decodedDrumSequence, songURI);
writeSequenceToFile_withPostprocessing(decodedDrumSequence, songURI);

writeVelPosSequenceToFile([songURI '.transcr.vel'] , decodedV  );
writeVelPosSequenceToFile([songURI '.transcr.pos'] , decodedP  );
writeBarBeginsToFile([songURI '.transcr.barBegins'] , decodedP  );

end
