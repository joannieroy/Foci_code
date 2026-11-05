function [validFoci, fitModel, fitResult, allFociBBImage, incluFoci, fitSize]=getFociFits_twoTh(lblFoci, fociImage, bpassRadius, fittingBoxFactor, saturationTh, minR2, myDapiMask)
%function [validFoci, fitModel, fitResult, allFociBoundingBoxesImage]=getFociFits(lblFoci, fociImage, bpassRadius, fittingBoxFactor, saturationTh, minR2, myDapiMask)

% Notes from J.R. The idea is to run the fit model analysis with a set of foci that were detected with
% low contrast (ex. 5 instead of typical 10). Foci are attributed an inclusion/exclution criteria
% to discriminate the crap from real foci (using a first low R2 threshold - ex. 6), and a good or bad fit
% (using a high R2 threshold - ex. 0.9). We used to use a higher threshold
% for contrast (10) but, then, for high concentration of zeocin, we
% couldn't pick up dim foci. This way, we can pick up dim foci without the
% crap in the untreated cells. 

% also, the fittingBoxFactor is divided by two if there is two foci within
% one bounding box. 

%the analysis is done on the mat2gray

%% Settings

fittingBoxFactor  = 3;
%bpassRadius  = 8; % original 

inclR2 = 0.6; % Below this value, focus are considered artefact and rejected for analysis
minR2  = 0.9; % Below this value, focus are kept for analysis but considered 'bad'

allGoodFociBoundingBoxImage=uint8(fociImage);
allBadFociBoundingBoxImage =uint8(fociImage);

disp('This may take a while, you may consider a coffee break (or red wine, depending on the time)...and you probably need to take a walk too')

%% Fit settings

fitFunction=fittype('ValM+Amp*exp(-(((x-xo).*cosd(angulo)+(y-yo).*sind(angulo))./sx).^2-((-(x-xo).*sind(angulo)+(y-yo).*cosd(angulo))./sy).^2)',...
    'independent',{'x', 'y'}, 'dependent', 'z');
% coeffnames(fitFunction)

myOptions=fitoptions(fitFunction);
myOptions.Lower=[0 0 0 1 1 0 0];
myOptions.Upper=[1 Inf 360 fittingBoxFactor*bpassRadius fittingBoxFactor*bpassRadius Inf Inf];

%% Loop

for it=1:max(max(lblFoci))
    
    fittingBoxFactor  = 1; %original was 3

    thisFocusMask=lblFoci==it;
    thisFocusMask=imdilate(thisFocusMask, strel('square', fittingBoxFactor*bpassRadius));
    smallFocusBBox=regionprops(thisFocusMask, 'BoundingBox');
    smallFocusImage=imcrop(fociImage, smallFocusBBox(1).BoundingBox);

    lblFociBW = imbinarize(lblFoci,0);
    sumImage = thisFocusMask+lblFociBW;
    sumImageBW = imbinarize(sumImage,1); 
    sumsum = sum(sum(sumImageBW));

%     if sumsum>1
%         fittingBoxFactor = fittingBoxFactor/2; % original was 2
%         thisFocusMask=lblFoci==it;
%         thisFocusMask=imdilate(thisFocusMask, strel('square', fittingBoxFactor*bpassRadius));
%         
%            sumImage = thisFocusMask+lblFociBW;
%            sumImageBW = imbinarize(sumImage,1); 
%            sumsum = sum(sum(sumImageBW));
% 
%            %if sumsum>1
%             %fittingBoxFactor = fittingBoxFactor/2;
%             %thisFocusMask=lblFoci==it;
%             %thisFocusMask=imdilate(thisFocusMask, strel('square', fittingBoxFactor*bpassRadius));
%            %end
% 
%         smallFocusBBox=regionprops(thisFocusMask, 'BoundingBox');
%         smallFocusImage=imcrop(fociImage, smallFocusBBox(1).BoundingBox);
%     end

        xCoord=1:fittingBoxFactor*bpassRadius+1;
        yCoord=1:fittingBoxFactor*bpassRadius+1;
        [xx, yy]=meshgrid(xCoord, yCoord);
        [xData, yData, zData] = prepareSurfaceData( xx, yy, smallFocusImage );

        initialGuess=[max(max(smallFocusImage)) min(min(smallFocusImage)) 0 bpassRadius bpassRadius...
        fittingBoxFactor*bpassRadius/2 fittingBoxFactor*bpassRadius/2];

        myOptions.StartPoint=initialGuess;
        [fitModel{it}, thisResult]=fit([xData yData], zData, fitFunction, myOptions);

        if (thisResult.rsquare>minR2) && (thisResult.rsquare>inclR2) % Good foci & Included foci
            validFoci(it) = true; % = good
            incluFoci(it) = true; % = included
            %fitModel{it}  = sfit;
            fitResult{it} = thisResult;
            greenImage = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('square',2))*255);
            allGoodFociBoundingBoxImage=greenImage+allGoodFociBoundingBoxImage;
       
        elseif(thisResult.rsquare<minR2) && (thisResult.rsquare>inclR2) %Bad foci & Included foci
            validFoci(it) = false; % = bad
            incluFoci(it) = true;  % = included
            %fitModel{it}  = sfit;
            fitResult{it} = thisResult;
            blueImage = uint8(imdilate(edge(thisFocusMask, 'sobel'),strel('square',2))*255);
            allBadFociBoundingBoxImage=blueImage+allBadFociBoundingBoxImage;

        else % Bad & Excluded Foci
            validFoci(it) = false; % = bad
            incluFoci(it) = false; % = excluded
            %fitModel{it}  = sfit;
            fitResult{it} = thisResult; 
            
        end
end

         fociImage=uint8(imadjust(fociImage, stretchlim(fociImage, [0.01 0.999]))*255);
         nucleusImage = uint8(imdilate(edge(myDapiMask, 'sobel'),strel('disk',1))*255);
         redImage = fociImage;
         greenImage= allGoodFociBoundingBoxImage;
         blueImage = nucleusImage+allBadFociBoundingBoxImage;
         allFociBBImage=cat(3, redImage, greenImage, blueImage);


end


%%  Test for watershed of the mask. 
% a = imfill(allBadFociBoundingBoxImage);
% imshow(a, []);
% b = bwdist(~a);
% imshow(b, []);
% b = -b;
% imshow(b, []);
% L = watershed(b);
% imshow(L, []);
% L(~a)=0;
% imshow(L, []);
% LBW = imbinarize(L, 0);
% imshow(LBW, []);
