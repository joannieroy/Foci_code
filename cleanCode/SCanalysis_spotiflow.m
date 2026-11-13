function [singleCellFociResults]=SCanalysis_spotiflow(myDapiMask, dilatedFociMask, thisFociImageOriginal)
% This function calculates the mean intenmean intensity, sum of intensity and number of molecules for each focus. 


%% Initial parameters

singleCellFociResults=struct;
[lblCell, numCell]=bwlabel(myDapiMask);


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

% thisImageAdjusted=imsubtract(thisFociImageOriginal, bkIntensity);
thisImageAdjusted=thisFociImageOriginal;
for singCell=1: numCell
    thisCellMask=lblCell==singCell;

    
    lblFociRegions=bwlabel(dilatedFociMask).*thisCellMask;
    fociIds=unique(nonzeros(lblFociRegions));
    if numel(fociIds)>0
        for it=1:numel(fociIds)
            %NumberOfFociPerCell(it)=numel(fociIds);
            fociIndividualMeanIntesity(it)=mean2(thisImageAdjusted(lblFociRegions==fociIds(it))); 
            fociIndividualSumofIntensity(it)=sum(thisImageAdjusted(lblFociRegions==fociIds(it)), 'all');
            % NumberOfMoleculesPerFocus(it)=(fociIndividualSumofIntensity(it)/QB);
           % MaxFocus(it)=max(NumberOfMoleculesPerFocus(it));
           % MinFocus(it)=min(NumberOfMoleculesPerFocus(it));
        end
        
        singleCell(singCell).NumberOfFociPerCell=numel(fociIds);
        singleCell(singCell).IndividualMeanInt= fociIndividualMeanIntesity';
        singleCell(singCell).SumOfInt=fociIndividualSumofIntensity';
        % singleCell(singCell).MoleculesPerFocus=NumberOfMoleculesPerFocus';
        % singleCell(singCell).MaxFocus=max(NumberOfMoleculesPerFocus);
        % singleCell(singCell).MinFocus=min(NumberOfMoleculesPerFocus);
        % singleCell(singCell).MeanMolPerFocus=mean2(nonzeros(NumberOfMoleculesPerFocus));
        % singleCell(singCell).MedianMolPerFocus=median(NumberOfMoleculesPerFocus, 'all');
    else
        singleCell(singCell).NumberOfFociPerCell=0;
        singleCell(singCell).IndividualMeanInt= 0;  % Original
        %singleCell(singCell).IndividualMeanInt= NaN; % Test from Joannie
        singleCell(singCell).SumOfInt=0; % Original
        %singleCell(singCell).SumOfInt=NaN;  % Test from Joannie
        % singleCell(singCell).MoleculesPerFocus=0;
        % singleCell(singCell).MaxFocus=0;
        % singleCell(singCell).MinFocus=0;
        % singleCell(singCell).MeanMolPerFocus=0;
        % singleCell(singCell).MedianMolPerFocus=0;
    end
    %NumberOfFociPerCell=[];
    fociIndividualMeanIntesity=[];
    fociIndividualSumofIntensity=[];
    NumberOfMoleculesPerFocus=[];
    MaxFocus=[];
    MinFocus=[];
end
   singleCellFociResults=singleCell;