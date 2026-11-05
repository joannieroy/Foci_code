function outMask=dapiSegmentation(myImageInput, dapiSettings)

oneCellArea=dapiSettings.estimatedSize;
cellRadius=sqrt(oneCellArea/pi);

if dapiSettings.oneMultiColor
    if dapiSettings.hasDapi
        myImage=myImageInput(:,:,3);
    else %segmentation is based on foci
        myImage=myImageInput;
    end
else
    myImage=myImageInput;
end

%% Begin segmentation
if ~islogical(myImage) %% Loic images are already logicals
    BW=im2bw(myImage, graythresh(myImage));
else
    BW=myImage;
end

%% Create first mask

if dapiSettings.adaptive
    BW=imbinarize(myImage, 'adaptive');
else
    BW=imbinarize(myImage);
end

BW = imopen(BW, strel('disk',7)); % test JR for set of 26092022
BW2=imclose(BW, strel('disk',round(cellRadius/10)));
BW2=bwareaopen(BW2, round(oneCellArea/3));
BW2=imfill(BW2, 'holes');

%% Discard sections impossible to deal

wayTooBig=bwareaopen(BW2, oneCellArea*dapiSettings.maxGluedCells);
BW2=xor(BW2, wayTooBig);

%% cut small chucks
BW2=imopen(BW2, strel('disk', round(cellRadius/10)));
%BW2=imopen(BW2, strel('disk', round(cellRadius/2))); % test JR for set of 26092022

%% Get objects properties
cellStats=regionprops(BW2, 'Area', 'PixelIdxList', 'BoundingBox');

BW2=uint16(BW2);

cellIdx=1;

%% Inspect one by one
%f=waitbar(0, 'Processing Nuclei');

for it=1:size(cellStats, 1)
   % waitbar(it/size(cellStats, 1),f);
    
    %% make a small images to improve speed
    
    smallImage=imcrop(myImage, cellStats(it).BoundingBox);
    bigMask=zeros(size(BW2));
    bigMask(cellStats(it).PixelIdxList)=BW2(cellStats(it).PixelIdxList);
    smallMask=logical(imcrop(bigMask, cellStats(it).BoundingBox));
    
    if dapiSettings.active
    %% ACtive contour refines the cell and may create several
  
        smallActive=zeros(size(smallMask));
        smallActive=smallMask;

        smallActive=activecontour(smallImage, smallMask);

        smallMask(smallMask)=smallActive(smallMask);
        smallMask=bwareaopen(smallMask, round(oneCellArea/3), 8);
    end   
        
    smallStats=regionprops(smallMask, 'Area', 'PixelIdxList');
    smallMask=uint16(smallMask);
    
    if sum(sum(smallMask))>=round(oneCellArea/3) % si sobrevivió algo

        for k=1:size(smallStats, 1)
            if floor(smallStats(k).Area/oneCellArea)<=1
                % it's small enough to be one cell
                smallMask(smallStats(k).PixelIdxList)=cellIdx;
                cellIdx=cellIdx+1;
            else
                % too big to be one cell
                [thisObjectLabel, numObj]=segmentNuclearCellCluster(smallStats(k).PixelIdxList, size(smallMask), smallImage, oneCellArea);

                thisObjectMask=zeros(size(smallMask));
                thisObjectMask(uint16(thisObjectLabel)~=0)=true;

                thisObjectLabel=thisObjectLabel+thisObjectMask*(cellIdx-1);

                smallMask(smallStats(k).PixelIdxList)=thisObjectLabel(smallStats(k).PixelIdxList);
                cellIdx=cellIdx+numObj;
            end

    %         bigMask=replaceBoundingBox(BW2, cellStats(it).BoundingBox, smallMask);
            bigMask=replaceBoundingBox(bigMask, cellStats(it).BoundingBox, smallMask);
            BW2(cellStats(it).PixelIdxList)=bigMask(cellStats(it).PixelIdxList);   
        end
    else % active contours achicó las células y no quedó nada
        bigMask=replaceBoundingBox(bigMask, cellStats(it).BoundingBox, smallMask);
        BW2(cellStats(it).PixelIdxList)=bigMask(cellStats(it).PixelIdxList);
    end
end
%close(f)

%% fill holes and clean shit made my activecontours
BW2=imfill(BW2, 'holes');

%% Look for hollow things to delete
cellSolidities=vertcat(regionprops(BW2, 'Solidity').Solidity);
unsolidCells=find(cellSolidities<dapiSettings.minSolidity);

if numel(unsolidCells)>0
    for it=unsolidCells'
        BW2(BW2==it)=0;
    end
end

%% Check if I have objects with intensities similar to background
cellMeanIntensity=vertcat(regionprops(BW2, myImage, 'MeanIntensity').MeanIntensity);
tooDim=find(cellMeanIntensity<dapiSettings.minIntensityFactor*std2(~BW.*myImage));

if numel(tooDim)>0
    for it=tooDim'
        BW2(BW2==it)=0;
    end
end

BW2=bwareaopen(BW2, round(oneCellArea/3));

outMask=BW2;




