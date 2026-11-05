%%
%A copy of this file must be placed in the root folder, assuming images 
%corresponding to the various conditions are stored in subfolders. All
%subfoloders will be processed with the same parameters
%Something like this:
% \experiment\readSettings.m
% \experiment\condition1\image1.tif
% \experiment\condition1\image2.tif
% \experiment\condition1\image3.tif
% \experiment\condition2\image1.tif
% \experiment\condition2\image2.tif
% \experiment\condition2\image3.tif
% \experiment\condition3\image1.tif
% \experiment\condition3\image2.tif
% \experiment\condition3\image3.tif

% Run the analysis using analyzeAllFolders.

%% folder name

fociSettings.FolderName='53BP1_' %how do we whant to call the folder (may be usefull if we analyse 2 proteins)

%% bpass pkfnd options
fociSettings.contrast=5; % how many times birighther than the sorrounding after the bandpass filter
fociSettings.radius=8; % radius of the foci
fociSettings.noiseSize=1;

%% more options
fociSettings.saveImages=true;
fociSettings.insideCells=true; % only count foci inside nuclei?

%% gaussian fit settings
fociSettings.fociFit=true;
fociSettings.fitRegionFactor=3; %gaussian fits are made on ROIs x times larger than the radius
fociSettings.fitSaturationTh=.2; %max percentage of pixels of the fitting ROI that can be saturated
fociSettings.fitMinRSquare=.9;
fociSettings.finMinInclusionRSquare=0.6; %J.R Added to exclude very bad foci (assuming higher contrast)

%% image type and filenames

fociSettings.dapiChannel=3;
fociSettings.fociChannel=1;
fociSettings.dapiRegExp='*ChanB*';
fociSettings.fociRegExp='*ChanA*.tif';
fociSettings.imageRegExp='*.tif';

%% cell segmentation
dapiSettings.oneMultiColor=false; % this must be true if cells will be segmented based on the foci image, with not dapi
dapiSettings.hasDapi=false; 
dapiSettings.discardBigCells=true;
dapiSettings.isYeast=false;
dapiSettings.estimatedSize=10000; %estimated size of a typical cell in pixels
dapiSettings.minSolidity=.7; %objects with solidity lower than this get discarded
dapiSettings.minIntensityFactor=3; % n times the STD of the backround. This gets rid of weird objects from large empty zones found with dapative thrshohold.
dapiSettings.adaptive=false;
dapiSettings.active=true;
dapiSettings.maxGluedCells=15; %if an object is larger than maxGluedCells*cellArea it is simply discarded.

