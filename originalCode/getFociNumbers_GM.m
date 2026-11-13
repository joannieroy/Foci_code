function TheseFociNumbersResults=getFociNumbers_GM(varargin)


if ~nargin==0

    dilatedFociMask=varargin{1};
    myDapiMask=varargin{2};
    thisFociImageOriginal=varargin{3};
    fociSettings=varargin{4};
    dapiSettings=varargin{5}; 
    bkIntensity=varargin{6}; 
    QB=varargin{7};
end

%% All foci analysis

fociMask=dilatedFociMask; %here it gets confused. Would it be better to erode the mask?
lblFociRegions=bwlabel(dilatedFociMask).*myDapiMask;
fociIds=unique(nonzeros(lblFociRegions));
thisImageAdjusted=imsubtract(thisFociImageOriginal, bkIntensity);
fociImage=mat2gray(thisFociImageOriginal);

    if numel(fociIds)>0
        for it=1:numel(fociIds)
            fociIndividualMeanIntesity(it)=mean2(thisImageAdjusted(lblFociRegions==fociIds(it)));
            fociIndividualSumofIntensity(it)=sum(thisImageAdjusted(lblFociRegions==fociIds(it)), 'all');
            NumberOfMoleculesPerFocus(it)=(fociIndividualSumofIntensity(it)/QB);
            
            

        end
        
        
        fociResults.fociIndividualMeanIntensity=fociIndividualMeanIntesity';
        fociResults.fociSumOfIntensity=fociIndividualSumofIntensity';
        fociResults.NumberOfMoleculesPerFocus=NumberOfMoleculesPerFocus';
        fociResults.meanPeakIntensity=mean(nonzeros(fociMask.*fociImage));
        fociResults.peakIntensities=nonzeros(fociMask.*fociImage);
       
    else
        fociResults.fociStats=[];
    end   

[lblCells, nCells] = bwlabel(myDapiMask);
lblFoci=lblFociRegions;

for k=1:nCells
    thisCellMask=lblCells==k;
    nFoci(k)=numel(unique(thisCellMask.*lblFoci))-1;
    FocalProteinIntensity(k)=mean2(nonzeros(thisImageAdjusted(k==lblCells)));
    FocalProteinSumIntensity(k)=sum(nonzeros(thisImageAdjusted(k==lblCells)));
end
    fociResults.eachCell=nFoci;
    fociResults.cellWithFoci=numel(nonzeros(unique(fociMask.*lblCells)));

% %% Count the number of foci per cell before the saturation filter
% lblFociPreSatFilter=bwlabel(AllfociMask);
% for x=1:nCells
%     thisCellMask=lblCells==x;
%     nFociPreSatFilter(x)=numel(unique(thisCellMask.*lblFociPreSatFilter))-1;
% end

% this fociResults includes foci that will be excluded later on. Numbers
% come from a double image


%ALL FOCI IMAGE
redImage=uint8(imadjust(fociImage, stretchlim(fociImage, [0.01 0.999]))*255);
greenImage=uint8(imdilate(edge(dilatedFociMask, 'sobel'),strel('disk',1))*255);
blueImage=uint8(imdilate(edge(myDapiMask, 'sobel'),strel('disk',1))*255);
fociResults.AllFocirgbImage=cat(3,redImage, greenImage, blueImage);

%% Cell by cell analysis
       
        AllFociResults.SingleCell=SCanalysis(myDapiMask, dilatedFociMask, thisFociImageOriginal, bkIntensity, QB);
        fociResults.AllFociPerCell=AllFociResults.SingleCell;
        fociResults.FociMeanIntensity=(extractfield(fociResults.AllFociPerCell, 'IndividualMeanInt'))';
        fociResults.FociSumIntensity=(extractfield(fociResults.AllFociPerCell, 'SumOfInt'))';
        fociResults.FociMolPerFocus=(extractfield(fociResults.AllFociPerCell, 'MoleculesPerFocus'))';
        
        TheseFociNumbersResults=fociResults;  
        
end
