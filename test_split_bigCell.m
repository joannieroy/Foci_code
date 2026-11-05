clear
close

mainFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Zeo_response 21052025';

% mainFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/EdU 30April2025/synchro 26hrs';

myList=dir(mainFolder);
isub = [myList(:).isdir]; 
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];

theseFolders=string(vertcat(char(folderNames)));

regMatches=regexpi(theseFolders, 'Zeo', 'match');
DataFolderList=find(~cellfun(@isempty, regMatches));
NewFolderNames=folderNames(DataFolderList);

        for itFolder=1:size(NewFolderNames,1)
       
        masterFolder=fullfile(mainFolder, NewFolderNames{itFolder});
        myFiles=dir(fullfile(masterFolder, '*Dapi.tif'));
        mkdir(fullfile(masterFolder, 'Masks_2'));
        
        % myFiles=dir(fullfile(masterFolder, '*647.tif'));
        % mkdir(fullfile(masterFolder, 'EdUMasks'));

        cp=cellpose(Model="cyto2");

                for itFile=1:size(myFiles, 1)
                    thisImageOriginal=imread(fullfile(masterFolder, myFiles(itFile).name));
                    thisImage=mat2gray(thisImageOriginal);
                    thismask=load(fullfile(masterFolder, 'Masks_1', [myFiles(itFile).name '.mat']));
                    bw=thismask.labels;
                    D = -bwdist(~bw); % negative distance transform
                            
                    % Suppress shallow minima
                    mask = imextendedmin(D, 2); % tune H-minima threshold
                    D2 = imimposemin(D, mask); 
                    L = watershed(D2);
                    
                    seg = bw;
                    seg(L == 0) = 0;
    
                    imshow(labeloverlay(thisImage, seg));

                    labels=seg;
                    imwrite(labels, fullfile(masterFolder,'Masks_2', [myFiles(itFile).name 'cellposeMask.jpg']), 'JPG');
                    save(fullfile(masterFolder,'Masks_2', [myFiles(itFile).name '.mat']), 'labels');


                end

        end










%  thismask=load('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Zeo_response 21052025/Zeo_000_10KPa/Masks_1/14.nd2.Dapi.tif.mat');
%  thisImageOriginal=imread('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Zeo_response 21052025/Zeo_000_10KPa/14.nd2.Dapi.tif');
% thisImage=mat2gray(thisImageOriginal);
% bw=thismask.labels;
% 
% D = -bwdist(~bw); % negative distance transform
% 
%                         % Suppress shallow minima
%                         mask = imextendedmin(D, 2); % tune H-minima threshold
%                         D2 = imimposemin(D, mask); 
%                         L = watershed(D2);
% 
%                         seg = bw;
%                         seg(L == 0) = 0;
% 
%                         imshow(labeloverlay(thisImage, bw));
