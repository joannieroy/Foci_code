 clear all
close all

masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Gelatin 20K';
destFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Gelatin 20K';


% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Repair_Gelatin_40X/55KPa';
% destFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments';
% newDir='53BP1_point_test_55Kpa';
newDir='53BP1_point_Image';

% newDir='53BP1_cellposemask';
% mkdir(fullfile(masterFolder, newDir));
mkdir(fullfile(destFolder, newDir));
rootFolder=newDir;

% myNumberFile='*tiff.mat';
myNumberFile='*AF488.tiff';

myList=dir(masterFolder);
isub = [myList(:).isdir]; %# returns logical vector
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = []; 

theseFolders=string(vertcat(char(folderNames)));

regMatches=regexpi(theseFolders, '00*', 'match');
%regMatches=regexpi(theseFolders, 'siRNA*', 'match');
% regMatches=regexpi(theseFolders, 'GY_*', 'match');

DataFolderList=find(~cellfun(@isempty, regMatches));
NewFolderNames=folderNames(DataFolderList);

FociImage=true;

for it=1:size(NewFolderNames, 1)
    for f=0:42
    for p=0:40
    

    [masterFolder '/' NewFolderNames{it}];
   
   thisFolder=fullfile(masterFolder, NewFolderNames{it});
    % thisFolder=fullfile(masterFolder, NewFolderNames{it}, '53bp1Results', 'Numbers');
    %thisFolder=fullfile(masterFolder, NewFolderNames{it}, '53bp1_small_7cResults', 'Numbers')
    % thisFolder=fullfile(masterFolder, NewFolderNames{it}, '53bp1_small_7cResults', 'Masks');

   theseFiles=dir(fullfile(thisFolder, myNumberFile));
   theseNames=string(vertcat(char(theseFiles.name)));

% for p=1:size(NewFolderNames, 1)
    %thisMoviePattern=strcat('Time\d{5}_WellA2_PointA2_', sprintf('%04d', p), '_ChannelDApi,AF488,TxRed_Seq\d{4}.tiff')
    %thisMoviePattern=strcat('Time\d{5}_WellA2_PointA2_', sprintf('%04d', p), '_ChannelDApi,AF488,Trans_Seq\d{4}.tiff')
    
    %thisMoviePattern=strcat('Time\d{5}_WellA1_PointA1_', sprintf('%04d', p), '_ChannelDApi,AF488_Seq\d{4}.tiff')
    
    % thisMoviePattern=strcat('Time\d{5}_WellA2_PointA2_', sprintf('%04d', p), '_ChannelDApi,Trans,TxRed_Seq\d{4}.tiff');
    % thisMoviePattern=strcat('cell_EGFP_TimeLapse-\d{3}_Points-', sprintf('%03d',p), '_Wells-000__Channel_AF488.tiff');

    % thisMoviePattern=strcat('cell_EGFP_TimeLapse-', sprintf('%03d',p),'_Points-', sprintf('%03d',it), '_Wells-000__Channel_AF488.tiff');
    thisMoviePattern=strcat('cell_EGFP_TimeLapse-', sprintf('%03d',p),'_Points-', sprintf('%03d',f), '_Wells-000__Channel_AF488.tiff');

    regMatches=regexpi(theseNames, thisMoviePattern, 'match');
    fileList=find(~cellfun(@isempty, regMatches));
    
    for k=1:numel(fileList)
        % if  ~isfolder(fullfile(masterFolder,rootFolder, sprintf('%04d', p)))
        %     % mkdir(fullfile(rootFolder, newDir, sprintf('%04d', p)))
        %     mkdir(fullfile(masterFolder, rootFolder, sprintf('%04d', p)))
        % end

           if  ~isfolder(fullfile(destFolder,rootFolder, sprintf('%04d', p)))
            % mkdir(fullfile(rootFolder, newDir, sprintf('%04d', p)))
            mkdir(fullfile(destFolder, rootFolder, sprintf('%04d', p)))
          end
        sourceFile=fullfile(thisFolder, theseFiles(fileList(k)).name);
        
        %destFile=fullfile(rootFolder, [sprintf('%04d', p),'splitImages'], theseFiles(fileList(k)).name);
        
        % destFile=fullfile(masterFolder, rootFolder, sprintf('%04d', p), theseFiles(fileList(k)).name);
        destFile=fullfile(destFolder, rootFolder, sprintf('%04d', p), theseFiles(fileList(k)).name);

        copyfile(sourceFile, destFile)
        % load(fullfile(thisFolder, theseFiles(fileList(k)).name));
        
        % A=imread(fullfile(thisFolder, theseFiles(fileList(k)).name));
        % B=uint8(mat2gray(A)*255);
        % imwrite(B, fullfile(destFolder, rootFolder, sprintf('%04d', p), [theseFiles(fileList(k)).name '.jpg']), 'JPG');

        % load(fullfile(thisFolder, theseFiles(fileList(k)).name));
        % mask=labels;
        % imwrite(labels, fullfile(masterFolder, rootFolder, sprintf('%04d', p), [theseFiles(fileList(k)).name '_cellposeMask.jpg']), 'JPG');
   
               if FociImage==true
                   MakeFociOverlay(thisFolder, )
                  
    
    
    
    end
    end
    end
end


