function analyzeThisFolder(varargin)

%% Analysis parameters

%% section for testing on one folder
if nargin==4
    myFolder=varargin{1};
    fociSettings=varargin{2};
    QB=varargin{3};
    dapiSettings=varargin{4};
   
else
    myFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Time points/20KPa/0001';
    fociSettings.contrast=5; % how many times birighther than the sorrounding after the bandpass filter
    fociSettings.radius=5; % radius of the foci
    fociSettings.noiseSize=0.5;
    fociSettings.saveImages=true;
    fociSettings.insideCells=true; % only count foci inside nuclei?
    fociSettings.discardBigCells=true;
    fociSettings.FolderName='53bp1';
    fociSettings.oneMultiColor=false;
    fociSettings.dapiChannel=3;
    fociSettings.fociChannel=1;
    fociSettings.dapiRegExp='*AF488.tiff';
    fociSettings.fociRegExp='*AF488.tiff';
    fociSettings.imageRegExp='*.tif';
    fociSettings.hasDapi=false;
    fociSettings.deadPixels=true;
    fociSettings.saturationfilter=false;
    fociSettings.fociFit=true;
    fociSettings.fitRegionFactor=3; %gaussian fits are made on ROIs x times larger than the radius
    fociSettings.fitSaturationTh=.2; %max percentage of pixels of the fitting ROI that can be saturated
    fociSettings.fitMinRSquare=.9;
    fociSettings.finMinInclusionRSquare=0.6;
    dapiSettings.isYeast=false;


    QB=1;
end


today = date;

            mkdir(fullfile(myFolder,[fociSettings.FolderName 'Results' ], 'Images'))
            mkdir(fullfile(myFolder,[fociSettings.FolderName 'Results' ], 'Numbers'))
            mkdir(fullfile(myFolder, [fociSettings.FolderName 'Results' ], 'Masks'))
            mkdir(fullfile(myFolder, [fociSettings.FolderName 'Results' ], 'Overlay'))

folderData=[];
folderFoci=[];
usefullFiles={};

myImageFiles=dir(fullfile(myFolder,fociSettings.fociRegExp));
myFociFiles=myImageFiles;
numFiles=size(myImageFiles,1);
myDapiFiles=dir(fullfile(myFolder,fociSettings.dapiRegExp));

for it=1:numFiles

    [num2str(it) ' of ' num2str(numFiles)]
       
        thisFociImageOriginal=imread(fullfile(myFolder,myFociFiles(it).name));
        thisFociImage=mat2gray(thisFociImageOriginal);
        
        thisDapiImageOriginal=imread(fullfile(myFolder,myDapiFiles(it).name));
        thisDapiImage=mat2gray(thisDapiImageOriginal);
        
        iMax=max(max(thisFociImageOriginal));
        bkIntensity=0;
        outMask=(dapiSegmentation(thisDapiImage, dapiSettings));
        myDapiMask=bwlabel(outMask);
        %load(fullfile(myFolder,'Masks_1', [myDapiFiles(it).name '.mat'])); %it loads the background mask depending on the type of images we feed 
        %myDapiMask=labels;

    thisName=myImageFiles(it).name;   
   
    %[fociResults, FociSegmentationMasks, overlayImage]=getThisImageAnalyzed_GM_focibycell(myDapiMask,thisFociImage,fociSettings, iMax, thisFociImageOriginal, bkIntensity, QB, myFolder, thisName);
    [fociResults, FociSegmentationMasks]=getThisImageAnalyzed_JR09Feb22(myDapiMask,thisFociImage,fociSettings, dapiSettings, iMax, thisFociImageOriginal, bkIntensity, QB, myFolder, thisName);
    %[fociResults, FociSegmentationMasks]=getThisImageAnalyzed_GM(dapiImage,fociImage,fociSettings, dapiSettings, iMax, thisFociImageOriginal, bkIntensity, QB, masterFolder, thisName)

    
    % if fociResults.numCells>0
    % % imshow(fociResults.AllFocirgbImage)
    % end

    %% save files
   if size(fields(fociResults), 1)>0
        if fociSettings.saveImages
           
            if isfield(fociResults, 'GoodFocirgbImage')
               imwrite(fociResults.GoodFocirgbImage, fullfile(myFolder ,[fociSettings.FolderName 'Results'], 'Images', [myImageFiles(it).name '_GoodFoci.jpg']), 'JPG');
            end

            if isfield(fociResults, 'BadFocirgbImage')
               imwrite(fociResults.BadFocirgbImage, fullfile(myFolder ,[fociSettings.FolderName 'Results'], 'Images', [myImageFiles(it).name '_BadFoci.jpg']), 'JPG');
               imwrite(FociSegmentationMasks.GodAndBadMask, fullfile(myFolder, [fociSettings.FolderName 'Results'], 'Images', [myImageFiles(it).name '_GoodAndBadFoci.tif']), 'tif');
            end

            if isfield(fociResults, 'AllFocirgbImage')
               imwrite(fociResults.AllFocirgbImage, fullfile(myFolder ,[fociSettings.FolderName 'Results'], 'Images', [myImageFiles(it).name '_AllFoci.jpg']), 'JPG'); 
            end

            if isfield(fociResults, 'AllFociBBImage')
               imwrite(fociResults.AllFociBBImage, fullfile(myFolder ,[fociSettings.FolderName 'Results'], 'Images', [myImageFiles(it).name '_AllFociBBImage.jpg']), 'JPG'); 
            end

            if isfield(fociResults, 'ExcFocirgbImage')
               imwrite(fociResults.ExcFocirgbImage, fullfile(myFolder ,[fociSettings.FolderName 'Results'], 'Images', [myImageFiles(it).name '_ExcFocirgbImage.jpg']), 'JPG'); 
            end
        
    
        
        end


        save(fullfile(myFolder ,[fociSettings.FolderName 'Results'], 'Numbers', [myImageFiles(it).name '.mat']), 'fociResults');
        save(fullfile(myFolder, [fociSettings.FolderName 'Results'], 'Masks', [myImageFiles(it).name '.mat']), 'FociSegmentationMasks');
        
        if exist('overlayImage', 'var')
            imwrite(overlayImage, fullfile(myFolder,[fociSettings.FolderName 'Results'], 'Overlay',[myImageFiles(it).name '_Overlay.jpg']), 'JPG');
        end
        
        folderData=[folderData; fociResults.numCells, fociResults.cellWithFoci, fociResults.numFoci, ...
            fociResults.meanPeakIntensity, fociResults.meanFociIntesity];
        usefullFiles=cat(1, usefullFiles, myImageFiles(it).name);
    end
end

% % Save Excel results
% 
% resultsTable=table;
% resultsTable.fileName=usefullFiles;
% resultsTable.numberOfCells=folderData(:,1);
% resultsTable.numberOfCellsWithFoci=folderData(:,2);
% resultsTable.numberFociInImage=folderData(:,3);
% resultsTable.peakFociIntensity=folderData(:,4);
% resultsTable.meanFociIntensity=folderData(:,5);
% 
% writetable(resultsTable, fullfile(myFolder ,[fociSettings.FolderName 'Results'], 'Numbers', 'fociStats.xls'))
% 
save(fullfile(myFolder ,[fociSettings.FolderName 'Results'], 'Numbers', [datestr(now, 'yymmdd_HHMMSS') 'parametersLog.mat']), 'fociSettings');

