% helper function. Loads a file with annotation
function [sizeAnnotation, annotationTs] = loadAnnotationTs(songURI, suffixDrumType)

annotationTs = [];
sizeAnnotation = 0;	

songURIExt = [songURI suffixDrumType]; 

s = dir(songURIExt);

	if exist(songURIExt, 'file')
   
        if (s.bytes == 0)
            sizeAnnotation = 0;	

        else
                annotationTs = dlmread(songURIExt);	

                sizeAnnotation =	size(annotationTs,1);

        end
        
    end

    
end