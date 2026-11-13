function [withoutSmallObjects, numBigObjects]=discardSmallObjects(withSmallObjects, thresholdSize)
%% Discards all objects smaller than a factor (thresholdSize) of the biggest object in the image
[maskLabeled, numObjects]=bwlabel(withSmallObjects, 8);

objectsData=regionprops(maskLabeled, 'Area');
maxObjectArea=max([objectsData.Area]);
smallObjects=find([objectsData.Area]<maxObjectArea/thresholdSize);

for itObjects=smallObjects
    maskLabeled(maskLabeled==itObjects)=0;
end
withoutSmallObjects=maskLabeled;
withoutSmallObjects(maskLabeled~=0)=1;

numBigObjects=numObjects-size(smallObjects,2);