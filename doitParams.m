
path1 = '/Users/joro/Documents/Linz/drumsbBarModel/barmodelMIDIPositions/mean/';
path1Viterbi =  '/Users/joro/Documents/Linz/drumsbBarModel/barmodelMIDIPositions/meanVITERBI/';

paths = {pathViterbi, '/home/user/norm/', '/home/user/mean+norm/', '/home/user/nomean+nonorm/'};


  doMovingMedian = 0;
doNorm = 0;
[crossValidatedPrec, crossValidatedRecall] = doitCrossVal(paths{4}, doMovingMedian, doNorm);
 

doMovingMedian = 1;
doNorm = 0;
[crossValidatedPrec, crossValidatedRecall] = doitCrossVal(paths{1}, doMovingMedian, doNorm);
 
 
 doMovingMedian = 0;
doNorm = 1;
[crossValidatedPrec, crossValidatedRecall] = doitCrossVal(paths{2}, doMovingMedian, doNorm);
 
 doMovingMedian = 1;
doNorm = 1;
[crossValidatedPrec, crossValidatedRecall] = doitCrossVal(paths{3}, doMovingMedian, doNorm);
 
