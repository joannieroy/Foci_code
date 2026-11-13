function [newDapiMask]=saturationfilter(DapiMask, FociImage, saturationTh)

% if nargin==3
% DapiMask=varagin{1};
% FociImage=varagin{2};
% fociSettings.maxsaturation=varagin{3};
% end
I=mat2gray(FociImage);
CellMask=I.*DapiMask;
[lblcell, numcell]=bwlabel(DapiMask);
FilteredMask=DapiMask;
for itCell=1:numcell
    % if  max(max(CellMask(lblcell==itCell)))==saturationTh
    %    FilteredMask(lblcell==itCell)=0;
    % end
    if sum(sum(CellMask(lblcell==itCell)==1))>numel(CellMask(lblcell==itCell))*saturationTh % 10 percent saturation
        FilteredMask(lblcell==itCell)=0;
    end

end

newDapiMask=FilteredMask;


