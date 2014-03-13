
function calcTransMatrixFull(V, P)

transMatrix=doTransMatrix(V,P);


    transMatrixFull = zeros(V,P,V,P);

    % construct full matrix. 
    for toV=1:V
        for toP=1:P

            % prepare a table with trans probs for a fixed target state 
            tableTransProb = zeros(V,P);
            for fromV = 1:V
                for fromP = 1:P
                tableTransProb(fromV, fromP) = getTransProb(transMatrix,fromV,fromP,toV,toP);
                end
            end


            transMatrixFull(:,:,toV,toP) = tableTransProb;


        end
    end

end