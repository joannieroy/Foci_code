%% Read me file - foci analysis 
% Updated 2026-11-13 by J.Roy

How to organise the files: 
- In one folder, put all condition folders with foci images to analyse. Don't put other folders. 
- Make sure to consider which confocal you used and adapt the readSetting.m file accordingly. 
- You may need to do some adjustments of folders in 'analyseAllFolder.m' and 'GatherThemAll_reRUN.m'
- Many things are obsolete in the code since this code was originally used for SPIDA analysis (number of molecules per focus)

Pre-processing: 
(-1) 'export_czi_tiles.m', which give tiff_export folders from .czi

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

Once the foci are detected, there is some post-processing to do in order to visualise and graph the data:

(10) QC Check visually the images in 53BP1_Results, Image folder. In Image J
(7) 'GatherThemAll_reRUN.m' calls:
    (8)'getTheNumbersSpiDA_reRun', which gathers the results of all images of a experimental conditions, for all conditions. 
(9) Manually move all the files called 'YourNumberToPlot.mat' to a single folder that you will call using the following:

And then, you can finally visualise data using:
(10) 'Results_Visualisation.m'



