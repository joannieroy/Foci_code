function [EdUResults, FociSegmentationMasks]=getThisImageAnalyzed_EdU(myDapiMask,EdUImage)

%% saturation filter

if fociSettings.saturationfilter
    newDapiMask=saturationfilter(myDapiMask, thisFociImageOriginal, fociSettings.maxsaturation);
    myDapiMask=newDapiMask;
end
  

[lblCells, nCells] = bwlabel(myDapiMask);
% EdUMask=EdUImage.*myDapiMask;


for k=1:nCells
    thisCellMask=lblCells==k;
    
    FocalProteinIntensity(k)=mean2(nonzeros(EdUImage(k==lblCells)));
    FocalProteinSumIntensity(k)=sum(nonzeros(EdUImage(k==lblCells)));
end

EdUResults.numCells=nCells;
EdUResults.FocalProteinIntensity=FocalProteinIntensity;
EdUResults.FocalProteinSumIntensity=FocalProteinSumIntensity;


%% EdU RGB image
        redImage=uint8(imadjust(EdUImage, stretchlim(EdUImage, [0.01 0.999]))*255);
        % A=imdilate(fociMask, strel('disk', 4));
        % greenImage=uint8(imdilate(edge(A, 'sobel'), strel('disk', 1))*255);  
        greenImage=uint8(zeros(size(redimage))*255);
        %greenImage=uint8(imdilate(edge(dilatedFociMask, 'sobel'),strel('disk',1))*255);
        blueImage=uint8(imdilate(edge(myDapiMask, 'sobel'),strel('disk',1))*255);
        EdUResults.rgbImage=cat(3,redImage, greenImage, blueImage);
        
