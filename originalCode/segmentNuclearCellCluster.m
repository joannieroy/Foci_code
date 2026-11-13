function [labeledClusters, numObj]=segmentNuclearCellCluster(PixelIdxList, imSize, intensityImage, oneCellArea)


%% get row column of each pixel
[r,c]=ind2sub(imSize, PixelIdxList);
idxIntensity=intensityImage(PixelIdxList);

%% Cell centroids based on kmeans
[~, clusterCentroids] = kmeans([r c 20*idxIntensity], floor(numel(PixelIdxList)/oneCellArea),'Distance','sqeuclidean','Replicates',5);

%% impose cell centroids as minima for a watershed
minsLocations=sub2ind(imSize, round(clusterCentroids(:,1)), round(clusterCentroids(:,2)));
minimaImage=zeros(imSize);
minimaImage(minsLocations)=true;

thisObjectMask=zeros(imSize);
thisObjectMask(PixelIdxList)=true;

negImpose=imimposemin(imcomplement(intensityImage.*thisObjectMask), minimaImage);

%% watershed 

wshThisObject=watershed(negImpose);
thisObjectMask(wshThisObject==0)=0;

thisObjectMask=bwareaopen(thisObjectMask, round(oneCellArea/3), 4);

%% check if there is any big claster left

newStats=regionprops(thisObjectMask, 'PixelIdxList');

for k=1:size(newStats, 1)
    if floor(numel(newStats(k).PixelIdxList)/oneCellArea)>=1
        [r,c]=ind2sub(imSize, newStats(k).PixelIdxList);
        [pixelAssignment, ~] = kmeans([r c], floor(numel(newStats(k).PixelIdxList)/oneCellArea),'Distance','sqeuclidean','Replicates',5);

        for it=1:max(pixelAssignment)
            frontierImage=zeros(imSize);
            frontierImage(newStats(k).PixelIdxList(find(pixelAssignment==it)))=it;
            frontierImage=bwmorph(frontierImage==it, 'remove');
            thisObjectMask(frontierImage)=0;
        end
    end
end

thisObjectMask=bwareaopen(thisObjectMask, round(oneCellArea/3), 8);

[labeledClusters, numObj]=bwlabel(thisObjectMask);



