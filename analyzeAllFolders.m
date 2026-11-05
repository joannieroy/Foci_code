 clear 'all'
 close 'all'

%% loop through folders and do the full analysis
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/PC3 Zeo challenge 03072025/New Folder With Items';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Zeo_response 21052025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Zeo 10ug 02052025';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/LNCaP/Zeo_response 24082025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/Trypsin PC3 SB/Zeo challenge 26082025/done';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/LNCaP/Zeo challenge 03092025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/19Dec2025 dose reponse 2_4_8 GY';
masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/11Dec2025_2GY';


%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/53bp1gfp vs zeoR/19092025';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Foci detection Machine Learning/Training data set';

% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Foci detection Machine Learning/Clement/U2OS/untitled folder';

myList=dir(masterFolder);
isub = [myList(:).isdir]; %# returns logical vector
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];

QB=1;

theseFolders=string(vertcat(char(folderNames)));

% regMatches=regexpi(theseFolders, 'Zeo', 'match');
regMatches=regexpi(theseFolders, 'IR', 'match');

DataFolderList=find(~cellfun(@isempty, regMatches));
NewFolderNames=folderNames(DataFolderList);
% NewFolderNames=folderNames;

    fociSettings.contrast=5; % how many times birighther than the sorrounding after the bandpass filter
    % fociSettings.radius=3; % radius of the foci - it was 3 for the 4-8-12 c
    fociSettings.radius=3; %for the 60X images
    % fociSettings.noiseSize=2.5; %it was 3 for the 4-8-12 c
    fociSettings.noiseSize=2.5; %for the 60X images
    fociSettings.saveImages=true;
    fociSettings.insideCells=true; % only count foci inside nuclei?
    fociSettings.discardBigCells=true;
    fociSettings.FolderName='53bp1_5c_2pt5ns_r3_cbc16Oct2025 ';
    
    fociSettings.oneMultiColor=false;
    fociSettings.dapiChannel=3;
    fociSettings.fociChannel=1;
    fociSettings.dapiRegExp='*Dapi.tif';
    fociSettings.fociRegExp='*488.tif';
    fociSettings.imageRegExp='*.tif';
    fociSettings.hasDapi=false;
    fociSettings.deadPixels=true;
    fociSettings.saturationfilter=true;
    fociSettings.maxsaturation=0.1 ;

    fociSettings.fociFit=false;
    fociSettings.fitRegionFactor=3; %gaussian fits are made on ROIs x times larger than the radius
    fociSettings.fitSaturationTh=.2; %max percentage of pixels of the fitting ROI that can be saturated
    fociSettings.fitMinRSquare=.9;
    fociSettings.finMinInclusionRSquare=0.6;





for it=1:size(NewFolderNames, 1)
% for it=1
    [masterFolder filesep NewFolderNames{it}]
    analyzeThisFolder([masterFolder filesep NewFolderNames{it}], fociSettings, QB);

end


 % clear 'all'
 % close 'all'

% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Gelatin 20K';
% %% loop through folders and do the full analysis
% 
% myList=dir(masterFolder);
% isub = [myList(:).isdir]; %# returns logical vector
% folderNames = {myList(isub).name}';
% folderNames(ismember(folderNames,{'.','..'})) = [];
% 
% QB=1;
% 
% theseFolders=string(vertcat(char(folderNames)));
% 
% regMatches=regexpi(theseFolders, '00*', 'match');
% % regMatches=regexpi(theseFolders, 'GY*', 'match');
% 
% DataFolderList=find(~cellfun(@isempty, regMatches));
% NewFolderNames=folderNames(DataFolderList);
% 
% 
%     fociSettings.contrast=7; % how many times birighther than the sorrounding after the bandpass filter
%     fociSettings.radius=4; % radius of the foci
%     fociSettings.noiseSize=0.5;
%     fociSettings.saveImages=true;
%     fociSettings.insideCells=true; % only count foci inside nuclei?
%     fociSettings.discardBigCells=true;
%     fociSettings.FolderName='53bp1_small_7c';
% 
%     fociSettings.oneMultiColor=false;
%     fociSettings.dapiChannel=3;
%     fociSettings.fociChannel=1;
%     fociSettings.dapiRegExp='*AF488.tiff';
%     fociSettings.fociRegExp='*AF488.tiff';
%     fociSettings.imageRegExp='*.tif';
%     fociSettings.hasDapi=false;
%     fociSettings.deadPixels=true;
%     fociSettings.saturationfilter=false;
% 
%     fociSettings.fociFit=true;
%     fociSettings.fitRegionFactor=3; %gaussian fits are made on ROIs x times larger than the radius
%     fociSettings.fitSaturationTh=.2; %max percentage of pixels of the fitting ROI that can be saturated
%     fociSettings.fitMinRSquare=.9;
%     fociSettings.finMinInclusionRSquare=0.6;
% 
% 
% 
% 
% 
% for it=1:size(NewFolderNames, 1)
% % for it=1
%     [masterFolder filesep NewFolderNames{it}]
%     analyzeThisFolder([masterFolder filesep NewFolderNames{it}], fociSettings, QB);
% 
% end
% 
% 
% disp 'Finally over! Time to check the results'
% 
% % %  clear 'all'
% % %  close 'all'
% % % 
% % % masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Time points/20KPa';
% % % %% loop through folders and do the full analysis
% % % 
% % % myList=dir(masterFolder);
% % % isub = [myList(:).isdir]; %# returns logical vector
% % % folderNames = {myList(isub).name}';
% % % folderNames(ismember(folderNames,{'.','..'})) = [];
% % % 
% % % QB=1;
% % % 
% % % theseFolders=string(vertcat(char(folderNames)));
% % % 
% % % regMatches=regexpi(theseFolders, '00*', 'match');
% % % % regMatches=regexpi(theseFolders, 'GY*', 'match');
% % % 
% % % DataFolderList=find(~cellfun(@isempty, regMatches));
% % % NewFolderNames=folderNames(DataFolderList);
% % % 
% % % 
% % %     fociSettings.contrast=5; % how many times birighther than the sorrounding after the bandpass filter
% % %     fociSettings.radius=4; % radius of the foci
% % %     fociSettings.noiseSize=0.5;
% % %     fociSettings.saveImages=true;
% % %     fociSettings.insideCells=true; % only count foci inside nuclei?
% % %     fociSettings.discardBigCells=true;
% % %     fociSettings.FolderName='53bp1_small';
% % % 
% % %     fociSettings.oneMultiColor=false;
% % %     fociSettings.dapiChannel=3;
% % %     fociSettings.fociChannel=1;
% % %     fociSettings.dapiRegExp='*AF488.tiff';
% % %     fociSettings.fociRegExp='*AF488.tiff';
% % %     fociSettings.imageRegExp='*.tif';
% % %     fociSettings.hasDapi=false;
% % %     fociSettings.deadPixels=true;
% % %     fociSettings.saturationfilter=false;
% % % 
% % %     fociSettings.fociFit=true;
% % %     fociSettings.fitRegionFactor=3; %gaussian fits are made on ROIs x times larger than the radius
% % %     fociSettings.fitSaturationTh=.2; %max percentage of pixels of the fitting ROI that can be saturated
% % %     fociSettings.fitMinRSquare=.9;
% % %     fociSettings.finMinInclusionRSquare=0.6;
% % % 
% % % 
% % % 
% % % 
% % % 
% % % for it=1:size(NewFolderNames, 1)
% % % % for it=1
% % %     [masterFolder filesep NewFolderNames{it}]
% % %     analyzeThisFolder([masterFolder filesep NewFolderNames{it}], fociSettings, QB);
% % % 
% % % end
% % % 
% % % 
% % % disp 'Finally over! Time to check the results'
% % % 
% % %  clear 'all'
% % %  close 'all'
% % % 
% % % masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Time points/Glass_20';
% % % %% loop through folders and do the full analysis
% % % 
% % % myList=dir(masterFolder);
% % % isub = [myList(:).isdir]; %# returns logical vector
% % % folderNames = {myList(isub).name}';
% % % folderNames(ismember(folderNames,{'.','..'})) = [];
% % % 
% % % QB=1;
% % % 
% % % theseFolders=string(vertcat(char(folderNames)));
% % % 
% % % regMatches=regexpi(theseFolders, '00*', 'match');
% % % % regMatches=regexpi(theseFolders, 'GY*', 'match');
% % % 
% % % DataFolderList=find(~cellfun(@isempty, regMatches));
% % % NewFolderNames=folderNames(DataFolderList);
% % % 
% % % 
% % %     fociSettings.contrast=5; % how many times birighther than the sorrounding after the bandpass filter
% % %     fociSettings.radius=2; % radius of the foci
% % %     fociSettings.noiseSize=0.5;
% % %     fociSettings.saveImages=true;
% % %     fociSettings.insideCells=true; % only count foci inside nuclei?
% % %     fociSettings.discardBigCells=true;
% % %     fociSettings.FolderName='53bp1_small';
% % % 
% % %     fociSettings.oneMultiColor=false;
% % %     fociSettings.dapiChannel=3;
% % %     fociSettings.fociChannel=1;
% % %     fociSettings.dapiRegExp='*AF488.tiff';
% % %     fociSettings.fociRegExp='*AF488.tiff';
% % %     fociSettings.imageRegExp='*.tif';
% % %     fociSettings.hasDapi=false;
% % %     fociSettings.deadPixels=true;
% % %     fociSettings.saturationfilter=false;
% % % 
% % %     fociSettings.fociFit=true;
% % %     fociSettings.fitRegionFactor=3; %gaussian fits are made on ROIs x times larger than the radius
% % %     fociSettings.fitSaturationTh=.2; %max percentage of pixels of the fitting ROI that can be saturated
% % %     fociSettings.fitMinRSquare=.9;
% % %     fociSettings.finMinInclusionRSquare=0.6;
% % % 
% % % 
% % % 
% % % 
% % % 
% % % for it=1:size(NewFolderNames, 1)
% % % % for it=1
% % %     [masterFolder filesep NewFolderNames{it}]
% % %     analyzeThisFolder([masterFolder filesep NewFolderNames{it}], fociSettings, QB);
% % % 
% % % end
% % % 
% % 
disp 'Finally over! Time to check the results'