%% train obs probs
 function [ trainFeaturesGrouped gmm ] = traindoit(trainPath, whichFold, doMovingMedian, doNorm)

addpath('..');
addpath('train');

 



%%%%%%%%%%% preprocess train dir. 

%%%% 1) add _acc files. 
% script getAccompaniments.sh 
% in dir accompaniment_all_drummers

% 2) add txt files
% same script getAccompaniments.sh 

% mix files. 
% same script 

%%%% 3) combine timestamp-close annotations.
 
dbPath2 = fullfile(trainPath , '*.txt');
S = struct2cell(dir(dbPath2));
dbFileNames = S(1,:);

sizeDb = length(dbFileNames);


for j = 1 : sizeDb

	songName = strtok(dbFileNames{j} , '.');

	songURI = fullfile(trainPath, songName);

	combineDrumTypesENST(songURI);
	

end

%%%% 3.2) divide into drum types
% awk sript

% for file in `ls *.txt.combined`; do awk '{ if ($2=="bd_sd" || $2=="sd_bd" )  print $1}'  $file >${file}.bd_sd ; done
% for file in `ls *.txt.combined`; do awk '{ if ($2=="sd") print $1}'  $file >${file}.sd ; done
% for file in `ls *.txt.combined`; do awk '{ if ($2=="bd") print $1}'  $file >${file}.bd ; done

% result  extension .txt.combined.{drumType}


% merge 
% see steps from todoEval script

%%%% 4) extract features 
% script etractSpectralFlux.sh
% in dir accompaniment_all_drummers


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% train

V=8;
P=512;
D=4; 

addpath('train');


%%%%%%% transMatrix
% transMatrixFull = calcTransMatrixFull(V,P);


% positional Probs
% positionalProbs = trainPositionalProbs(D,P);



[ trainFeaturesGrouped gmm ] = trainObsLiks( trainPath , doMovingMedian, doNorm );

 end



 
 