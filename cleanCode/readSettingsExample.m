%%
% updated on Jan 27th 2023

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

% note regarding the Settings. We have updated the settings on Sep 13th to add the
% pixelSizeUm, to adjust the parameters that were in pixels.


%THERE IS AN OPTION TO RUN COLOCALIZATION ANALYSIS.
%parameters to adjust segmentation of the preference protein are at the end
%of the script

fociSettings.colocalization=true;


%% folder name

fociSettings.FolderName='53BP1_'; %how do we whant to call the folder (may be usefull if we analyse 2 proteins)

%% bpass pkfnd options

%fociSettings.pixelSizeUm = 0.13;  % um/px (field size of 149)
%fociSettings.pixelSizeUm = 0.1;   % um/px (field size of 153)
%fociSettings.pixelSizeUm = 0.051; % um/px (fluoView - to check)
fociSettings.pixelSizeUm = 0.104; % um/px (fluoView - new)

fociSettings.contrast=5; % how many times birighther than the sorrounding after the bandpass filter
fociSettings.radius=round(1.04/fociSettings.pixelSizeUm); % radius of the foci
fociSettings.noiseSize=(0.13/fociSettings.pixelSizeUm);

%% more options
fociSettings.saveImages=true;
fociSettings.insideCells=true; % only count foci inside nuclei?
fociSettings.saturationfilter=true; %remove cells with saturated pixel from the analysis
fociSettings.maxsaturation=65535; %max values of the images, it changes according to the type of images used - 16 bits
%fociSettings.maxsaturation=4096; %Station 1 - 12bits


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
%dapiSettings.pixelSizeUM = 0.13;   % um/px (field size of 149)
%dapiSettings.pixelSizeUm = 0.1;   % um/px (field size of 153)
%dapiSettings.pixelSizeUm = 0.051; % um/px (fluoView)
dapiSettings.pixelSizeUm = 0.104; % um/px (new fluoView)
dapiSettings.oneMultiColor = false; % this must be true if cells will be segmented based on the foci image, with not dapi
dapiSettings.hasDapi=false; 
dapiSettings.discardBigCells=true;
dapiSettings.isYeast=false;
dapiSettings.estimatedSize=round(1300/dapiSettings.pixelSizeUM); %estimated size of a typical cell in pixels
dapiSettings.minSolidity=.7; %objects with solidity lower than this get discarded
dapiSettings.minIntensityFactor=3; % n times the STD of the backround. This gets rid of weird objects from large empty zones found with dapative thrshohold.
dapiSettings.adaptive=false;
dapiSettings.active=true;
dapiSettings.maxGluedCells=15; %if an object is larger than maxGluedCells*cellArea it is simply discarded. This number is not in pixel. 


            %% Set the parameters for foci segmentation _ Reference Image
            
            %fociSettings.pixelSizeUm = 0.13;  % um/px (field size of 149)
            %fociSettings.pixelSizeUm = 0.1;   % um/px (field size of 153)
            %fociSettings.pixelSizeUm = 0.051; % um/px (fluoView - to check)
            REFfociSettings.pixelSizeUm = 0.104; % um/px (fluoView - new)
            
            REFfociSettings.contrast=5; % how many times birighther than the sorrounding after the bandpass filter
            REFfociSettings.radius=round(1.5/REFfociSettings.pixelSizeUm); % radius of the foci - trying to make it bigger
            REFfociSettings.noiseSize=(0.13/REFfociSettings.pixelSizeUm);
            
            
            REFfociSettings.saveImages=true;
            REFfociSettings.insideCells=true; % only count foci inside nuclei?
            REFfociSettings.saturationfilter=true; %remove cells with saturated pixel from the analysis
            %fociSettings.maxsaturation=65535; %max values of the images, it changes according to the type of images used - 16 bits
            REFfociSettings.maxsaturation=4096; %Station 1 - 12bits
            
            
            %GAUSSIAN FIT
            REFfociSettings.fociFit=true;
            REFfociSettings.fitRegionFactor=3; %gaussian fits are made on ROIs x times larger than the radius
            REFfociSettings.fitSaturationTh=.2; %max percentage of pixels of the fitting ROI that can be saturated
            REFfociSettings.fitMinRSquare=.9;
            REFfociSettings.finMinInclusionRSquare=0.6; %J.R Added to exclude very bad foci (assuming higher contrast)
            
            % IMAGE TYPE AND FILE NAME
            
            REFfociSettings.dapiChannel=3;
            REFfociSettings.fociChannel=1;
            REFfociSettings.dapiRegExp='*_C1.tif';
            REFfociSettings.fociRegExp='*_C2.tif';
            REFfociSettings.imageRegExp='*.tif';




