function A = calcATable(C, transMatrixFull)

P= size(C,2);
V = size(C,1);

% @param C is table for probabilities p(v,t| y_{1:t-1}) at prev. time frame
% C(V,P)
A=zeros(V,P);




for toV=1:V
	for toP=1:P
		
	tmpTransMatrix = transMatrixFull(:,:,toV,toP);
		
% 			disp( fprintf('at to v= %d and toP= %d' , toV, toP ));

		tmp = tmpTransMatrix .* C;
		A(toV,toP) = sum(sum( tmp));  
	end
end



end