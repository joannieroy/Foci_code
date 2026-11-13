function [singleCellFociResults, CbCRes]=CellbyCellFoci(myDapiMask, dilatedFociMask, thisFociImageOriginal, bkIntensity, QB, destFolder, fociSettings, thisName)
% This function calculates the mean intenmean intensity, sum of intensity and number of molecules for each focus. 

%clear 
%close all

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpiDA_St1_09Nov2022/53BP1GFP_Alexa/53BP1GFP/Zeocin00500';
newDir=[thisName 'CellbyCell Watershed'];
mkdir(fullfile(destFolder, [fociSettings.FolderName 'Results'],newDir));

%load('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpiDA_St1_09Nov2022/53BP1GFP_Alexa/53BP1GFP/Zeocin00500/53BP1_Results/Masks/mEGFP_004_C2.tif.mat')

% myDapiMask=FociSegmentationMasks.DapiMask;
% dilatedFociMask=FociSegmentationMasks.AllFociMask;
% thisFociImageOriginal=imread('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/53BP1 GFP vs Alexa/09Nov2022/53BP1GFP/Zeocin00500/mEGFP_004_C2.tif');
% bkIntensity=155.5697;
% QB=9.8963;

%% Initial parameters

singleCellFociResults=struct;
[lblCell, numCell]=bwlabel(myDapiMask);
cellStats=regionprops(myDapiMask, 'BoundingBox', 'PixelIdxList', 'Centroid');


%% watershed on dilatedFociMask
%  This is done in order to cut joined dilated foci mask. When foci are
%  closed by, they join when we dilate the mask. It screws with calculations for
%  the sum of intensity, hence the number of molecules. 

a     = dilatedFociMask;
b     = bwdist(~a);
b     = -b;
L     = watershed(b);
L(~a) = 0;
LBW   = imbinarize(L, 0);
LBW   = bwareaopen(LBW, 10); % removes the tiny objects artificially created by the watershed. 

dilatedFociMask = LBW;


%% Calculating mean intensity, sum of intensity and number of molecules for each focus. 

thisImageAdjusted=imsubtract(thisFociImageOriginal, bkIntensity);

for singCell=1: numCell

                        ThisCellMask=zeros(size(myDapiMask));
                        ThisCellMask(lblCell==singCell)=1;
                        
                        OneCell=thisFociImageOriginal.*uint16(ThisCellMask);
                        TotProteinIntensity=sum(nonzeros(OneCell), 'all');
                        MeanProteinIntensity=mean2(nonzeros(OneCell));


                        Z=cellStats(singCell).BoundingBox;
                        dilatedFactor=0.2;
                        DilatedBB=dilatedBB(Z,dilatedFactor, thisFociImageOriginal);
                        %OneCell=thisImageOriginal.*uint16(cellsMask)
                        OneCell=imcrop(OneCell, DilatedBB);
                        %OneCell=imcrop(OneCell, cellStats(singCell).BoundingBox);
                        OneCellMask=imcrop(myDapiMask, DilatedBB);
                        %OneCellMask=imcrop(cellsMask, cellStats(singCell).BoundingBox);
                        
                        OneCellFociMask=imcrop(dilatedFociMask, DilatedBB);

                        lblFociRegions=bwlabel(dilatedFociMask).*ThisCellMask;
                        lblFociRegions=imcrop(lblFociRegions, DilatedBB);

                        %B=bwlabel(LBW).*ThisCellMask;
                        %B=imcrop(B, DilatedBB);
                        %% make the images and momtage

                        smallImage=imcrop(thisFociImageOriginal, DilatedBB);
                        smallImage=mat2gray(smallImage);
                        redImage=uint8(imadjust(smallImage, stretchlim(smallImage, [0.01 0.999]))*255);
                        A=imdilate(OneCellFociMask, strel('disk', 1));
                        greenImage=uint8(imdilate(edge(A, 'sobel'), strel('disk', 1))*255);  
                        
                        %greenImage=uint8(imdilate(edge(dilatedFociMask, 'sobel'),strel('disk',1))*255);
                        blueImage=uint8(imdilate(edge(OneCellMask, 'sobel'),strel('disk',1))*255);
                        SCFociImage=cat(3,redImage, greenImage, blueImage);

                        M=montage({mat2gray(OneCell) lblFociRegions, SCFociImage}, 'Size', [1 3]);
                        data=get(M, 'CData');
                        
                        % save
                        imwrite(data, fullfile(destFolder, [fociSettings.FolderName 'Results'],newDir, [num2str(singCell) 'montage.tif']), 'TIF');
                        imwrite(OneCell, fullfile(destFolder,[fociSettings.FolderName 'Results'], newDir,['Cell' num2str(singCell) '_BB.tif']), 'TIF'); %save the small image
                        save(fullfile(destFolder,[fociSettings.FolderName 'Results'], newDir, ['Cell' num2str(singCell) '.Cellmask.mat']), 'OneCellMask'); 
                        imwrite(SCFociImage, fullfile(destFolder, [fociSettings.FolderName 'Results'], newDir,['Cell' num2str(singCell) '_RGB.tif']), 'TIF');

                        %imwrite(OneCell, fullfile(masterFolder, newDir, name, ['Im_' name '_Cell0' num2str(singCell) '_BB.tif']), 'TIF'); %save the small image
                        %save(fullfile(masterFolder, newDir, ['Im_' name '_Cell' num2str(singCell) '.Cellmask.mat']), 'OneCellMask'); 

   % thisCellMask=lblCell==singCell;

   

    %lblFociRegions=bwlabel(dilatedFociMask).*thisCellMask;
    fociIds=unique(nonzeros(lblFociRegions));
    if numel(fociIds)>0
        for it=1:numel(fociIds)
            %NumberOfFociPerCell(it)=numel(fociIds);
            fociIndividualMeanIntesity(it)=mean2(thisImageAdjusted(lblFociRegions==fociIds(it))); 
            fociIndividualSumofIntensity(it)=sum(thisImageAdjusted(lblFociRegions==fociIds(it)), 'all');
            NumberOfMoleculesPerFocus(it)=(fociIndividualSumofIntensity(it)/QB);
           % MaxFocus(it)=max(NumberOfMoleculesPerFocus(it));
           % MinFocus(it)=min(NumberOfMoleculesPerFocus(it));
        end
        
        singleCell(singCell).NumberOfFociPerCell=numel(fociIds);
        singleCell(singCell).IndividualMeanInt= fociIndividualMeanIntesity';
        singleCell(singCell).SumOfInt=fociIndividualSumofIntensity';
        singleCell(singCell).MoleculesPerFocus=NumberOfMoleculesPerFocus';
        singleCell(singCell).MaxFocus=max(NumberOfMoleculesPerFocus);
        singleCell(singCell).MinFocus=min(NumberOfMoleculesPerFocus);
        singleCell(singCell).TotProteinIntensity=TotProteinIntensity;
        singleCell(singCell).TotMolPerCell=TotProteinIntensity/QB;
        singleCell(singCell).MeanMolPerFocus=mean2(nonzeros(NumberOfMoleculesPerFocus));
        singleCell(singCell).MedianMolPerFocus=median(NumberOfMoleculesPerFocus, 'all');
        
    else
        singleCell(singCell).NumberOfFociPerCell=0;
        singleCell(singCell).IndividualMeanInt= 0;  % Original
        %singleCell(singCell).IndividualMeanInt= NaN; % Test from Joannie
        singleCell(singCell).SumOfInt=0; % Original
        %singleCell(singCell).SumOfInt=NaN;  % Test from Joannie
        singleCell(singCell).MoleculesPerFocus=0;
        singleCell(singCell).MaxFocus=0;
        singleCell(singCell).MinFocus=0;
        singleCell(singCell).TotProteinIntensity=TotProteinIntensity;
        singleCell(singCell).TotMolPerCell=TotProteinIntensity/QB;
        singleCell(singCell).MeanMolPerFocus=0;
        singleCell(singCell).MedianMolPerFocus=0;

    end

    save(fullfile(destFolder ,[fociSettings.FolderName 'Results'], newDir, ['Cell' num2str(singCell) '.SCResults.mat']), 'singleCell');
    %NumberOfFociPerCell=[];
    
    fociIndividualMeanIntesity=[];
    fociIndividualSumofIntensity=[];
    NumberOfMoleculesPerFocus=[];
    MaxFocus=[];
    MinFocus=[];
end
   singleCellFociResults=singleCell;
   
% cell numbers
                        CbCRes.TotProteinIntensity=sum(nonzeros(OneCell));
                        CbCRes.MeanProteinIntensity=mean2(nonzeros(OneCell));
                        




end