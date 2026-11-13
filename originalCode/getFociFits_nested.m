function [validFoci, fitModel, fitResult, allFociBBImage, incluFoci, fitSize]=getFociFits_nested(lblFoci, fociImage, bpassRadius, fittingBoxFactor, saturationTh, minR2, myDapiMask)


% Notes from J.R. The idea is to run the fit model analysis with different
% bounding box size and to keep the r2 associated to each focus. Later on,
% foci are attributed an inclusion/exclution criteria, a best size fit and
% a good or bad fit. 

%the analysis is done on the mat2gray

%% Settings

fittingBoxFactor  = 3;
bpassRadiusBBbig  = 8; % original 
bpassRadiusBBmed  = 4;
bpassRadiusBBsma  = 2;

inclR2 = 0.6; % Below this value, focus are considered artefact and rejected for analysis
minR2  = 0.9; % Below this value, focus are kept for analysis but considered 'bad'

%% Fit settings

fitFunction=fittype('ValM+Amp*exp(-(((x-xo).*cosd(angulo)+(y-yo).*sind(angulo))./sx).^2-((-(x-xo).*sind(angulo)+(y-yo).*cosd(angulo))./sy).^2)',...
    'independent',{'x', 'y'}, 'dependent', 'z');
% coeffnames(fitFunction)

myOptions=fitoptions(fitFunction);
myOptions.Lower=[0 0 0 1 1 0 0];
myOptions.Upper=[1 Inf 360 fittingBoxFactor*bpassRadius fittingBoxFactor*bpassRadius Inf Inf];

%% First Loop - Big foci

for it=1:max(max(lblFoci))
    
% add a loop here to see if there is an other foci within the bb box. if
% so, reduce the bb by half (maybe dividing the factor?)

    thisFocusMask=lblFoci==it;
    thisFocusMask=imdilate(thisFocusMask, strel('square', fittingBoxFactor*bpassRadiusBBbig));
    smallFocusBBox=regionprops(thisFocusMask, 'BoundingBox');
    smallFocusImage=imcrop(fociImage, smallFocusBBox(1).BoundingBox);

        xCoord=1:fittingBoxFactor*bpassRadiusBBbig+1;
        yCoord=1:fittingBoxFactor*bpassRadiusBBbig+1;
        [xx, yy]=meshgrid(xCoord, yCoord);
        [xData, yData, zData] = prepareSurfaceData( xx, yy, smallFocusImage );

        initialGuess=[max(max(smallFocusImage)) min(min(smallFocusImage)) 0 bpassRadiusBBbig bpassRadiusBBbig...
        fittingBoxFactor*bpassRadiusBBbig/2 fittingBoxFactor*bpassRadiusBBbig/2];

        myOptions.StartPoint=initialGuess;
        [fitModel{it}, thisResult]=fit([xData yData], zData, fitFunction, myOptions);

        if (thisResult.rsquare>minR2) && (thisResult.rsquare>inclR2) % Good foci & Included foci
            validFociBig(it) = true;
            incluFociBig(it) = true;
            fitResultBig{it} = thisResult;
       
        elseif(thisResult.rsquare<minR2) && (thisResult.rsquare>inclR2) %Bad foci & Included foci
            validFociBig(it) = true;
            incluFociBig(it) = false;
            %fitModelBig{it}  = sfit;
            fitResultBig{it} = thisResult;

        else % Bad & Excluded Foci
            validFociBig(it) = false;
            incluFociBig(it) = false;
            %fitModelBig{it}  = sfit;
            fitResultBig{it} = thisResult; 

        end
end

%%  Second Loop - Medium Foci

for it=1:max(max(lblFoci))
    
    thisFocusMask=lblFoci==it;
    thisFocusMask=imdilate(thisFocusMask, strel('square', fittingBoxFactor*bpassRadiusBBmed));
    smallFocusBBox=regionprops(thisFocusMask, 'BoundingBox');
    smallFocusImage=imcrop(fociImage, smallFocusBBox(1).BoundingBox);

        xCoord=1:fittingBoxFactor*bpassRadiusBBmed+1;
        yCoord=1:fittingBoxFactor*bpassRadiusBBmed+1;
        [xx, yy]=meshgrid(xCoord, yCoord);
        [xData, yData, zData] = prepareSurfaceData( xx, yy, smallFocusImage );

        initialGuess=[max(max(smallFocusImage)) min(min(smallFocusImage)) 0 bpassRadiusBBmed bpassRadiusBBmed...
        fittingBoxFactor*bpassRadiusBBmed/2 fittingBoxFactor*bpassRadiusBBmed/2];

        myOptions.StartPoint=initialGuess;
        [fitModel{it}, thisResult]=fit([xData yData], zData, fitFunction, myOptions);

        if (thisResult.rsquare>minR2) && (thisResult.rsquare>inclR2) % Good foci & Included foci
            validFociMed(it) = true;
            incluFociMed(it) = true;
            fitResultMed{it} = thisResult;
       
        elseif(thisResult.rsquare<minR2) && (thisResult.rsquare>inclR2) %Bad foci & Included foci
            validFociMed(it) = true;
            incluFociMed(it) = false;
            %fitModelMed{it}  = sfit;
            fitResultMed{it} = thisResult;

        else % Bad & Excluded Foci
            validFociMed(it) = false;
            incluFociMed(it) = false;
            %fitModelMed{it}  = sfit;
            fitResultMed{it} = thisResult; 

        end
end

%%  Third Loop - Small Foci

for it=1:max(max(lblFoci))
    
    thisFocusMask=lblFoci==it;
    thisFocusMask=imdilate(thisFocusMask, strel('square', fittingBoxFactor*bpassRadiusBBsma));
    smallFocusBBox=regionprops(thisFocusMask, 'BoundingBox');
    smallFocusImage=imcrop(fociImage, smallFocusBBox(1).BoundingBox);

        xCoord=1:fittingBoxFactor*bpassRadiusBBsma+1;
        yCoord=1:fittingBoxFactor*bpassRadiusBBsma+1;
        [xx, yy]=meshgrid(xCoord, yCoord);
        [xData, yData, zData] = prepareSurfaceData( xx, yy, smallFocusImage );

        initialGuess=[max(max(smallFocusImage)) min(min(smallFocusImage)) 0 bpassRadiusBBsma bpassRadiusBBsma...
        fittingBoxFactor*bpassRadiusBBsma/2 fittingBoxFactor*bpassRadiusBBsma/2];

        myOptions.StartPoint=initialGuess;
        [fitModel{it}, thisResult]=fit([xData yData], zData, fitFunction, myOptions);

        if (thisResult.rsquare>minR2) && (thisResult.rsquare>inclR2) % Good foci & Included foci
            validFociSma(it) = true;
            incluFociSma(it) = true;
            fitModelSma{it}  = sfit;
            fitResultSma{it} = thisResult;
       
        elseif(thisResult.rsquare<minR2) && (thisResult.rsquare>inclR2) %Bad foci & Included foci
            validFociSma(it) = true;
            incluFociSma(it) = false;
            fitModelSma{it}  = sfit;
            fitResultSma{it} = thisResult;

        else % Bad & Excluded Foci
            validFociSma(it) = false;
            incluFociSma(it) = false;
            fitModelSma{it}  = sfit;
            fitResultSma{it} = thisResult; 

        end
end

%%  Attribution of Foci carateristics

for it=1:size(validFociBig,2)
    if    validFociBig(it)==1 && validFociMed(it)==1 && validFociSma(it)== 1
        validFoci(it)=true;
    else
        validFoci(it)=false;
    end

    if incluFociBig(it)==1 && incluFociMed(it)==1 && incluFociMed(it)== 0
        incluFoci(it)=false;
    else
        incluFoci(it)=true;
    end

    if (fitResultBig{it}.rsquare>fitResultMed{it}.rsquare) && (fitResultBig{it}.rsquare>fitResultSma{it}.rsquare)
        fitResult{it}=fitResultBig{it};
        fitSize(it)=1;
    elseif (fitResultMed{it}.rsquare>fitResultBig{it}.rsquare) && (fitResultMed{it}.rsquare>fitResultSma{it}.rsquare)
        fitResult{it}=fitResultMed{it};
        fitSize(it)=2;
    else 
        fitResult{it}=fitResultSma{it};
        fitSize(it)=3; 
    end

end

%%  Creating images

baseImage = uint8(imadjust(fociImage, stretchlim(fociImage, [0.3 0.999]))*255);
%baseImage = uint8(imadjust(fociImage, stretchlim(fociImage, [0.01 0.999]))*255);

allGoodFociBBImage = baseImage;
allBadFociBBImage  = baseImage;
rejectedFociImage  = baseImage;
greenImage         = uint8(zeros(size(fociImage,1),size(fociImage,2)));     
redImage           = uint8(zeros(size(fociImage,1),size(fociImage,2))); 
blueImage          = uint8(zeros(size(fociImage,1),size(fociImage,2))); 
nucleusImage       = uint8(imdilate(edge(myDapiMask, 'sobel'),strel('disk',1))*255);
finalfociImage     = uint8(imadjust(fociImage, stretchlim(fociImage, [0.3 0.999]))*255);

for it=1:max(max(lblFoci))
    
    thisFocusMask=lblFoci==it;
    
    if fitSize(it)==1
    
    %thisFocusMask=imdilate(thisFocusMask, strel('square', fittingBoxFactor*bpassRadiusBBbig));
    
        if validFoci(it)==1 && incluFoci(it) == 1
        greenImage = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('disk',fittingBoxFactor*bpassRadiusBBbig/2))*255);
        elseif validFoci(it)==1 && incluFoci(it) == 0
        redImage   = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('square',fittingBoxFactor*bpassRadiusBBbig/2))*255);
        else 
        blueImage  = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('diamond',fittingBoxFactor*bpassRadiusBBbig/2))*255);
        end

    elseif fitSize(it)==2
    %thisFocusMask=imdilate(thisFocusMask, strel('square', fittingBoxFactor*bpassRadiusBBmed));

        if validFoci(it)==1 && incluFoci(it) == 1
        greenImage = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('disk',fittingBoxFactor*bpassRadiusBBmed/2))*255);
        elseif validFoci(it)==1 && incluFoci(it) == 0
        redImage   = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('square',fittingBoxFactor*bpassRadiusBBmed/2))*255);
        else 
        blueImage  = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('diamond',fittingBoxFactor*bpassRadiusBBmed/2))*255);
        end

    else
    %thisFocusMask=imdilate(thisFocusMask, strel('square', fittingBoxFactor*bpassRadiusBBsma));
    
        if validFoci(it)==1 && incluFoci(it) == 1
        greenImage = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('disk',fittingBoxFactor*bpassRadiusBBsma/2))*255);
        elseif validFoci(it)==1 && incluFoci(it) == 0
        redImage   = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('square',fittingBoxFactor*bpassRadiusBBsma/2))*255);
        else 
        blueImage  = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('diamond',fittingBoxFactor*bpassRadiusBBsma/2))*255);
        end    
    
    end

allGoodFociBBImage = greenImage + allGoodFociBBImage;
allBadFociBBImage  = redImage   + allBadFociBBImage;
rejectedFociImage  = blueImage  + rejectedFociImage;

end

finalRedImage   = allBadFociBBImage;
finalGreenImage = allGoodFociBBImage + finalfociImage;
finalBlueImage  = rejectedFociImage  + nucleusImage;

allFociBBImage  = cat(3, finalRedImage, finalGreenImage, finalBlueImage);

end
