close all
%thisFolder=dir('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/53BP1 GFP vs Alexa/SpIDA_St1_17May2023_GFPvs546');
DapiMask=FociSegmentationMasks.DapiMask;
FociMask=FociSegmentationMasks.AllFociMask;
%%
A=edge(FociSegmentationMasks.DapiMask);
A=imdilate(A, strel('disk', 1));
%imshow(A)
imwrite(A,'/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/siRNA/SpIDA_St1_02Feb2024_siRNA_GFPvsRIf1/Foci/Im_5nMZeo500_04DapiMask.tif', 'tif');
   
%%
%B=FociSegmentationMasks.GoodFociMask+FociSegmentationMasks.BadFociMask;
%B=FociMask;
B=ColocFociMask;
B=imdilate(B, strel('disk', 5));
% B=imdilate(edge(B), strel('disk', 1));
% imshow(B)
%imwrite(B, '/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/53BP1 GFP vs Alexa/SpIDA_St1_14Aug2023_GFPvsAlexa647_&u2os/foci analysis/Im_05FociMask.tif', 'tif')
%imwrite(B,'/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_19April2024_GFPvs546/Foci/Zeo_500/Im_Zeo500_04GFP_fociMask.tif', 'tif')
imwrite(B,'/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/siRNA/SpIDA_St1_02Feb2024_siRNA_GFPvsRIf1/Foci/Im_5nMZeo500_04colocMask.tif', 'tif');

C=(FociSegmentationMasks.GoodFociMask+FociSegmentationMasks.BadFociMask);
D=C-ColocFociMask;
D=imdilate(D, strel('disk', 5));
% D=imdilate(edge(D), strel('disk', 1));
% imshow(B)
%imwrite(B, '/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/53BP1 GFP vs Alexa/SpIDA_St1_14Aug2023_GFPvsAlexa647_&u2os/foci analysis/Im_05FociMask.tif', 'tif')
%imwrite(B,'/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_19April2024_GFPvs546/Foci/Zeo_500/Im_Zeo500_04GFP_fociMask.tif', 'tif')
imwrite(D,'/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/siRNA/SpIDA_St1_02Feb2024_siRNA_GFPvsRIf1/Foci/Im_5nMZeo500_04NotcolocMask.tif', 'tif');
