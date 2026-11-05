% Read the binary Cellpose mask
cellMask = imread('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Zeo 10ug 02052025/Zeo10_Glass_6hr/Masks/17.nd2.Dapi.tifcellposeMask.jpg');
cellMask = im2bw(cellMask);  % Ensure it's logical/binary

% Step 1: Compute the distance transform (inverted)
D = -bwdist(~cellMask);

% Step 2: Impose minima on background
D(~cellMask) = -Inf;

% Step 3: Apply watershed
L = watershed(D);

% Step 4: Mask watershed lines
separatedMask = cellMask;
separatedMask(L == 0) = 0;

% Step 5: Label each cell
labeledCells = bwlabel(separatedMask);

% Step 6: Visualize
figure;
imshow(label2rgb(labeledCells, 'jet', 'k'), 'InitialMagnification', 'fit');
title('Separated Cells via Watershed');
