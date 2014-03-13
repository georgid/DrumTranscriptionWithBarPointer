% get the trans probability form the sparse matrix

function transProb = getTransProb(transMatrix, fromV,fromP,toV,toP)

transProb =0;
% first possible target point
if(toV==transMatrix(fromV,fromP,1,1) && toP==transMatrix(fromV,fromP,1,2))
	transProb =transMatrix(fromV,fromP,1,3);
else if ( toV==transMatrix(fromV,fromP,2,1) && toP==transMatrix(fromV,fromP,2,2) )
		transProb =transMatrix(fromV,fromP,2,3);
	else if (toV==transMatrix(fromV,fromP,3,1) && toP==transMatrix(fromV,fromP,3,2))
					transProb =transMatrix(fromV,fromP,3,3);
		else
					transProb =0;
		end
	end
end
	
end
