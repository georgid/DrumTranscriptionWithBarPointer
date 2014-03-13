
 testPath = '/Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/accompaniment_all_drummers_test/';

testPath = '/Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/accompaniment_all_drummers_test_2fold/';

testPath = '/Users/joro/Documents/Linz/RHYTHMIC_14March/ENST-drums-extracted/accompaniment_all_drummers_test_3fold/';






%%%%%% preprocess annotation: meerge close events: 
% step1
dbPath2 = fullfile(testPath , '*.txt');
S = struct2cell(dir(dbPath2));
dbFileNames = S(1,:);

sizeDb = length(dbFileNames);


for j = 1 : sizeDb

	songName = strtok(dbFileNames{j} , '.');

	songURI = fullfile(testPath, songName);

	mergeDrumTypesENST(songURI);
	

end

% step2
%%%% divide into separate files for drum types
% awk sript

%  for file in `ls *.txt.merged`; do awk '{ if ($2=="sd") print $1}'  $file >${file}.sd ; done
%  for file in `ls *.txt.merged`; do awk '{ if ($2=="bd") print $1}'  $file >${file}.bd ; done



%%%%%% first validation set

songURI = [testPath 'drummer_1_107_minus-one_salsa_sticks'];

songURI = [testPath 'drummer_1_114_minus-one_celtic-rock_brushes'];


	
songURI = [testPath 'drummer_2_115_minus-one_salsa_sticks'];


songURI = [testPath 'drummer_2_124_minus-one_bossa_sticks'];



songURI= [testPath 'drummer_3_126_minus-one_salsa_sticks'];

songURI= [testPath 'drummer_3_134_minus-one_bossa_sticks'];


%%%% second val set 
songURI = [testPath 'drummer_2_116_minus-one_rock-60s_sticks'];

testPath = [path 'accompaniment_all_drummers_test_3fold/' ];
%%%% ......third
songURI = [testPath '/drummer_1_109_minus-one_metal_sticks'];
songURI =  [testPath  '/drummer_1_112_minus-one_funk_rods'];
songURI =   [testPath '/drummer_2_117_minus-one_metal_sticks'];
songURI = [ testPath  '/drummer_2_120_minus-one_funk_sticks'];
songURI =  [testPath  'drummer_3_128_minus-one_metal_sticks'];
songURI =  [testPath 'drummer_3_131_minus-one_funk_sticks'];


% one song
[prec, recal] = evalPrecRecallForOneSong(songURI)


% eval all songs
[prec, recall] = evalPrecRecallForAllsongs(testPath);





