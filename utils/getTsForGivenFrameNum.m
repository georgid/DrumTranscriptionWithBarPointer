
function ts = getTsForGivenFrameNum(frameNum)

% fixed to 10 ms. in feature extraction script it is so much
lengthHop=1/100;

		ts = (frameNum-1) * lengthHop; 

end