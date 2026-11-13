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
fociSettings.FolderName='GFP53BP1_'; %how do we whant to call the folder (may be usefull if we analyse 2 proteins)

%% bpass pkfnd options
%fociSettings.pixelSizeUm = 0.104; % um/px (fluoView - new)
fociSettings.pixelSizeUm = 0.1; % um/px (zeiss)
fociSettings.contrast=5; % how many times birighther than the sorrounding after the bandpass filter
fociSettings.radius=round(1.04/fociSettings.pixelSizeUm); % radius of the foci
fociSettings.noiseSize=(0.13/fociSettings.pixelSizeUm);

%% more options
fociSettings.saveImages=true;
fociSettings.insideCells=true; % only count foci inside nuclei?
fociSettings.saturationfilter=true; %remove cells with saturated pixel from the analysis
%fociSettings.maxsaturation=65535; %max values of the images, it changes according to the type of images used - 16 bits%
%fociSettings.maxsaturation=4096; %Station 1 - 12bits
fociSettings.maxsaturation=255; %Station 1 - 12bits

%% gaussian fit settings
fociSettings.fociFit=true;
fociSettings.fitRegionFactor=3; %gaussian fits are made on ROIs x times larger than the radius
fociSettings.fitSaturationTh=.2; %max percentage of pixels of the fitting ROI that can be saturated
fociSettings.fitMinRSquare=.9;
fociSettings.finMinInclusionRSquare=0.6; %J.R Added to exclude very bad foci (assuming higher contrast)

%% image type and filenames
fociSettings.dapiChannel=4;
fociSettings.fociChannel=1;
fociSettings.dapiRegExp='*T4*';
fociSettings.fociRegExp='*T1.tif';
fociSettings.imageRegExp='*.tif';
fociSettings.colocalization=true;

%% cell segmentation
%dapiSettings.pixelSizeUm = 0.104; % um/px (new fluoView)
dapiSettings.pixelSizeUm = 0.1; % um/px (Zeiss CB)
dapiSettings.oneMultiColor = false; % this must be true if cells will be segmented based on the foci image, with not dapi
dapiSettings.hasDapi=false; 
dapiSettings.discardBigCells=true;
dapiSettings.isYeast=false;
dapiSettings.estimatedSize=round(2000/dapiSettings.pixelSizeUm); %estimated size of a typical cell in pixels
dapiSettings.minSolidity=.7; %objects with solidity lower than this get discarded
dapiSettings.minIntensityFactor=3; % n times the STD of the backround. This gets rid of weird objects from large empty zones found with dapative thrshohold.
dapiSettings.adaptive=false;
dapiSettings.active=true;
dapiSettings.maxGluedCells=15; %if an object is larger than maxGluedCells*cellArea it is simply discarded. This number is not in pixel. 
