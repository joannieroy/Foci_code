%% Read me file - foci analysis

How to organise the files: 
- In one folder, put all condition folders with foci images to analyse. Don't put other folders. 
- Put also the QBResults file in each folder.
- Put the readSetting.m file in the root folder. 
- Make sure to consider which confocal you used and adapt the readSetting.m file accordingly. 

Some pre-processing to do to get the files well named:
(-2) 'PutTheNumber.m' This changes the names of the images. Run this analysis for each condition folder. Move the images out of the folder. 
(-1.5) If you have both Red and Green observations, you can divide the folder with images in two. Not to confuse both analysis. 
(-1) 'backgroundnoise.m' This creates the mask for the background noise. Run this analysis for each condition folder.

For the foci analysis, starts with:
(1) 'analyzeAllFolder.m',  which calls:
(2) 'analyzeThisFolder.m', which calls:
(3) 'getThisImageAnalyzed_JR09Feb22', which calls:
a dectection algorithm based on :
    (4) 'pkfnd.m'
    followed by a quality control of the foci to discriminate good and bad:
    (5) 'getFociFits_twoTh.m'
    and also analyses the foci (mean intensity, sum of intensity, number of molecules, number of foci per nucleus):
    (6) 'SCanalysis.m'
'getThisImageAnalyzed' also creates images to manually quality control found foci. 

Once the foci are analysed, there is some post-processing to do in order to visualise and graph the data:

(10) QC Check visually the images in 53BP1_Results, Image folder. In Image J
(7) 'GatherThemAll.m' calls:
    (8)'getTheNumbers.m', which gathers the results of all images of a experimental conditions, for all conditions. 
(9) Manually move all the files called 'YourNumberToPlot.mat' to a single folder that you will call using the following:

And then, you can finally visualise data using:
(10) 'fociHistogramsSC_JR'
(11) 'fortheTable.m' is a way to translate the number of molecules/focus into an excel sheet. 


