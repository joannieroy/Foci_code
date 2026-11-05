clear
close all

masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/PC3 Zeo challenge 03072025/60X/Zeo_00100_Glass_60';

%myFiles=dir(fullfile(masterFolder, '*ChanA*.tif'));
%myFiles=dir(fullfile(masterFolder, '*ch00*')); %stellaris

myFilesGreen=dir(fullfile(masterFolder, '*488.tif')); % station 1

%myFilesRed=dir(fullfile(masterFolder, '*_C3.tif')); % station 1

% myFiles=dir(fullfile(masterFolder, '*GFP*.tif')); %station 13

mkdir(fullfile(masterFolder, 'Background noise mask'));
myFilesRed=myFilesGreen;



uiwait(msgbox("Select a background region for each image. Get set, ready and... click click click!","Background Noise","modal"));


for itFile=1:size(myFilesGreen,1)
% for   itFile=6

    thisImageOriginal=imread(fullfile(masterFolder, myFilesGreen(itFile).name));
    bkRegion=roipoly(imadjust(mat2gray(thisImageOriginal))); 
    bkIntensity=mean2(thisImageOriginal(bkRegion));

save(fullfile(masterFolder, 'Background noise mask', [myFilesGreen(itFile).name '.bkmask.mat']), 'bkRegion', 'bkIntensity');   
%     save(fullfile(masterFolder, 'Background noise mask', [myFilesRed(itFile).name '.bkmask.mat']), 'bkRegion', 'bkIntensity');     
end

msgbox('You did it. all background noise mask done', 'Background Noise','modal')

close all


% imshow(cat(3, mat2gray(thisImage), imdilate(bwperim(cellsMask), strel('disk',3)), imdilate(bwperim(cellsMask), strel('disk',3))))
%     
%     answer1=questdlg('Happy with the mask?', 'Satisfaction', 'Yes', 'No', 'Yes')
%     if strcmp(answer1,'No')
%         answer2='Draw';
%         cellsMask=false(size(cellsMask));
%         while strcmpi(answer2, 'Draw')
%             thisMask=roipoly(cat(3, mat2gray(thisImage), bwperim(cellsMask), bwperim(cellsMask)));
%             answer2=questdlg('Keep drawing?', 'Satisfaction', 'Draw', 'No', 'Draw');
%             cellsMask=cellsMask|thisMask;
%         end
%     end