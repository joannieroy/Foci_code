function [singleCellFociResults]=SCanalysisForColoc(myDapiMask, dilatedFociMask, thisFociImageOriginal)
singleCellFociResults=struct;
[lblCell, numCell]=bwlabel(myDapiMask);



for singCell=1: numCell
    thisCellMask=lblCell==singCell;
    lblFociRegions=bwlabel(dilatedFociMask).*thisCellMask;
    fociIds=unique(nonzeros(lblFociRegions));
    if numel(fociIds)>0
        for it=1:numel(fociIds)
            %NumberOfFociPerCell(it)=numel(fociIds);
            fociIndividualMeanIntesity(it)=mean2(thisFociImageOriginal(lblFociRegions==fociIds(it))); 
            fociIndividualSumofIntensity(it)=sum(thisFociImageOriginal(lblFociRegions==fociIds(it)), 'all');
            
        end
        
        singleCell(singCell).NumberOfFociPerCell=numel(fociIds);
        singleCell(singCell).IndividualMeanInt= fociIndividualMeanIntesity';
        singleCell(singCell).SumOfInt=fociIndividualSumofIntensity';
       
    end
    %NumberOfFociPerCell=[];
    fociIndividualMeanIntesity=[];
    fociIndividualSumofIntensity=[];
end
   singleCellFociResults=singleCell;