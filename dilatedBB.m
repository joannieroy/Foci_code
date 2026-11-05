function newBB=dilatedBB(varargin)
% dilate the bounding box equally of an arbiotrary factor choosen by the
% user
% Z containes the coordinated of the bounding box
% box"
Z=varargin{1};
dilateFactor=varargin{2};
%image=varargin{3};


   
    x = Z(1);
    y = Z(2);
    w = Z(3);
    h = Z(4);

    expandedX = x - dilateFactor * w;
    expandedY = y - dilateFactor * h;
    expandedW = (1 + 2 * dilateFactor) * w;
    expandedH = (1 + 2 * dilateFactor) * h;
    
    expandedX = max(expandedX, 1);
    expandedY = max(expandedY, 1);
    expandedW = min(expandedW, size(image, 2) - expandedX + 1);
    expandedH = min(expandedH, size(image, 1) - expandedY + 1);

newBB=[expandedX expandedY expandedW expandedH];