function transMatrix =  doTransMatrix(n_v,n_p)
% n_p = 5;
% n_v =4;

% fixed prob of change of velocity +- 1
pr = 0.05;


% 3rd dim is the only 3 probable next states, 4th is coordinate for toV, toP and prob for the target poin
transMatrix=zeros(n_v, n_p, 3, 3); 

for currVel = 1:n_v


	for currPos = 1:n_p

			% velocity of the three points
		transMatrix(currVel,currPos,1,1) = currVel -1;
		transMatrix(currVel,currPos,2,1) = currVel;
		transMatrix(currVel,currPos,3,1) = currVel +1;


		% position 

		transMatrix(currVel,currPos,1:3,2) = mod ( (currPos + currVel - 1 ), n_p )  + 1; 


		% probability 

		transMatrix(currVel,currPos,1,3) = pr/2;
			% same volocity
		transMatrix(currVel,currPos,2,3) = 1-pr;

		transMatrix(currVel,currPos,3,3) = pr/2;

		% velocity cannot decrease to 1-1= 0. 
		if transMatrix(currVel,currPos,1,1) == 0 
			%     So assign 0 prob.
				transMatrix(currVel,currPos,1,3) = 0;
				transMatrix(currVel,currPos,3,3) = pr;

		end



		% velocity cannot increase to max n_v + 1
		if transMatrix(currVel,currPos,3,1) == n_v + 1; 
			%     So assign 0 prob.
				transMatrix(currVel,currPos,3,3) = 0;
				transMatrix(currVel,currPos,1,3) = pr;

		end

	end

end


end