function [fociResults, FociSegmentationMasks, overlayImage]=getThisImageAnalyzed_spotiflow(myDapiMask,fociImage,fociSettings,thisFociImageOriginal, fociMask)

%% saturation filter

if fociSettings.saturationfilter
    newDapiMask=saturationfilter(myDapiMask, thisFociImageOriginal, fociSettings.maxsaturation);
    myDapiMask=newDapiMask;
end
% imshow(myDapiMask)
%remove objects smaller than a cell
    CC = bwconncomp(myDapiMask);
    CC=bwpropfilt(CC,"Area",[fociSettings.Cellsize Inf]);
    myDapiMask=(cc2bw(CC));


FociSegmentationMasks.DapiMask=myDapiMask;


lblFoci=bwlabel(fociMask);


%% All cells image analysis

dilatedFociMask=imdilate(fociMask, strel('disk', fociSettings.radius));
lblFociRegions=bwlabel(dilatedFociMask).*myDapiMask;
fociIds=unique(nonzeros(lblFociRegions));
% thisImageAdjusted=imsubtract(thisFociImageOriginal, bkIntensity);
thisImageAdjusted=thisFociImageOriginal;

    if numel(fociIds)>0
        for it=1:numel(fociIds)
            fociIndividualMeanIntesity(it)=mean2(thisImageAdjusted(lblFociRegions==fociIds(it)));
            fociIndividualSumofIntensity(it)=sum(thisImageAdjusted(lblFociRegions==fociIds(it)), 'all');
        end
        fociResults.fociIndividualMeanIntensity=fociIndividualMeanIntesity';
        fociResults.fociSumOfIntensity=fociIndividualSumofIntensity';
        
    else
        fociResults.fociStats=[];
    end   

[lblCells, nCells] = bwlabel(myDapiMask);
            if ~nCells == 0

                    for k=1:nCells
                        thisCellMask=lblCells==k;
                        nFoci(k)=numel(unique(thisCellMask.*lblFoci))-1;
                        FocalProteinIntensity(k)=mean2(nonzeros(thisImageAdjusted(k==lblCells)));
                        FocalProteinSumIntensity(k)=sum(nonzeros(thisImageAdjusted(k==lblCells)));
                    end
            


                fociResults.numCells=nCells;
                fociResults.cellWithFoci=numel(nonzeros(unique(fociMask.*lblCells)));
                fociResults.meanFociIntesity=mean(nonzeros(dilatedFociMask.*fociImage));
                fociResults.meanPeakIntensity=mean(nonzeros(fociMask.*fociImage));
                fociResults.peakIntensities=nonzeros(fociMask.*fociImage);
                fociResults.numFoci=sum(sum(fociMask));
                fociResults.eachCell=nFoci;%all foci before deleting saturated ones (if any)
                fociResults.FocalProteinIntensity=FocalProteinIntensity;
                fociResults.FocalProteinSumIntensity=FocalProteinSumIntensity;


        %% All foci RGB image
        
                redImage=uint8(imadjust(fociImage, stretchlim(fociImage, [0.01 0.999]))*255);
                A=fociMask.*myDapiMask;
                A=imdilate(A, strel('disk', 4));
                greenImage=uint8(imdilate(edge(A, 'sobel'), strel('disk', 1))*255);  
                
                %greenImage=uint8(imdilate(edge(dilatedFociMask, 'sobel'),strel('disk',1))*255);
                blueImage=uint8(imdilate(edge(myDapiMask, 'sobel'),strel('disk',1))*255);
                fociResults.AllFocirgbImage=cat(3,redImage, greenImage, blueImage);
                FociSegmentationMasks.AllFociMask=fociMask.*myDapiMask; 
        
        
         %% Overlay Image
                mask=edge(imdilate(FociSegmentationMasks.AllFociMask, strel('disk', 3)));
        
                        if size(mask, 3) > 1
                            mask = rgb2gray(mask); % Convert to grayscale if needed
                        end
        
                mask = mask > 0; % Ensure binary mask
                
                % img=thisFociImageOriginal;
                img=uint8(mat2gray(thisFociImageOriginal)*255);
                rgbImage = cat(3, img, img, img);
        
                % Create red overlay where mask is 1
                overlayImage = rgbImage;
                redChannel = overlayImage(:,:,1);
                redChannel(mask) = 255;  % Full red in masked area
                overlayImage(:,:,1) = redChannel;
        
                greenChannel = overlayImage(:,:,2);
                greenChannel(mask) = 0;
                overlayImage(:,:,2) = greenChannel;
        
                blueMask=imdilate(edge(myDapiMask, 'sobel'),strel('disk',1));
                blueChannel = overlayImage(:,:,3);
                blueChannel(blueMask) = 255;
                overlayImage(:,:,3) = blueChannel;
        
                % figure; imshow(overlayImage);
                % title(['Overlay for ', imageFiles(k).name]);
                % 
                % [~, name, ~] = fileparts(imageFiles(k).name);
                % outputName = fullfile(outputFolder, [name, '_overlay.png']);
                % imwrite(overlayImage, outputName);
        
        
        
        
        
        %% Fit foci as gaussians
        if fociSettings.fociFit && max(max(lblFoci))>0
        %    [validFoci, fitModel, fitQuality, allFociBoundingBoxesImage]=getFociFits(lblFoci, fociImage, fociSettings.radius, fociSettings.fitRegionFactor, fociSettings.fitSaturationTh, fociSettings.fitMinRSquare);
            [validFoci, fitModel, fitQuality, allFociBBImage, incluFoci]=getFociFits_twoTh(lblFoci, fociImage,fociSettings.radius, fociSettings.fitRegionFactor, fociSettings.fitSaturationTh, fociSettings.fitMinRSquare, myDapiMask);
        
            % delete non well fitted foci from the foci mask
            allFociIdx=find(lblFoci>0);
            badFoci=nonzeros(allFociIdx.*~validFoci'.*incluFoci');
            excFoci=nonzeros(allFociIdx.*~validFoci'.*~incluFoci');
            goodfociMask=fociMask;
            goodfociMask(badFoci)=0;
            goodfociMask(excFoci)=0;
            FociSegmentationMasks.GoodFociMask=goodfociMask; 
            
            for k=1:numel(validFoci)
                if validFoci(k)
                    allAmp(k)=fitModel{k}.Amp*iMax; 
                    allSx(k)=fitModel{k}.sx; 
                    allSy(k)=fitModel{k}.sy; 
                    allAngles(k)=fitModel{k}.angulo; 
                    allRSquare(k)=fitQuality{k}.rsquare; 
                    allSSE(k)=fitQuality{k}.sse; %sum of squares due to error the smaller the better
                else
                    allAmp(k)=NaN;
                    allSx(k)=NaN;
                    allSy(k)=NaN;
                    allAngles(k)=NaN;
                    allRSquare(k)=NaN;% J.R. Original
        %             allRSquare(k)=fitQuality{k}.rsquare;% J.R. Test
                    allSSE(k)=NaN;
                end
            end
            fitData.Amp=allAmp';
            fitData.Sx=allSx';
            fitData.Sy=allSy';
            fitData.Angle=allAngles';
            fitData.RSquare=allRSquare';
            fitData.SSE=allSSE';
            fociResults.gaussianFits=fitData;
            
            GoodFociMaskdilated=imdilate(edge(goodfociMask), strel('disk', fociSettings.radius)); %change the name
            
         %% bad foci mask 
         %here the idea is to keep the no-fitting foci and get their data separately. The two groups will be compared in SpIDA   
            badFociMask=fociMask.*~goodfociMask;
            badFociMask(excFoci)=0;
            excFociMask=fociMask.*~goodfociMask;
            excFociMask(badFoci)=0;
            BadOnesdilatedFociMask=imdilate(badFociMask, strel('disk', fociSettings.radius));
            excOnesdilatedFociMask=imdilate(excFociMask, strel('disk', fociSettings.radius));
            FociSegmentationMasks.BadFociMask=badFociMask; 
        
            GoodAndBadMask= imdilate((goodfociMask+badFociMask), strel('disk', round(fociSettings.radius/3)));
            FociSegmentationMasks.GodAndBadMask=edge(GoodAndBadMask);
        
            elseif max(max(lblFoci))>0
        %% do not use the gaussian fit
            dilatedFociMask=imdilate(fociMask, strel('disk', fociSettings.radius));
            FociSegmentationMasks.AllFociMask=fociMask; 
            end
            
        
        
        %[AllFociResults.SingleCell, AllFociResults.moreCbC]=CellbyCellFoci(myDapiMask, dilatedFociMask, thisFociImageOriginal, bkIntensity, QB,masterFolder, fociSettings, thisName);
        %destFolder=fullfile(masterFolder, [fociSetting.FolderName 'Results']);
        
            %% cell by cell analysis
                if fociSettings.fociFit && max(max(lblFoci))>0  
            
                %[GoodFociResults.SingleCell, GoodFociResults.moreCbC]=CellbyCellFoci(myDapiMask, GoodFociMaskdilated, thisFociImageOriginal, bkIntensity, QB, masterFolder, fociSettings, thisName);
                        GoodFociResults.SingleCell=SCanalysis(myDapiMask, GoodFociMaskdilated, thisFociImageOriginal);
                        fociResults.GoodFociPerCell=GoodFociResults.SingleCell; 
                        fociResults.GoodFociMeanIntensity=(extractfield(fociResults.GoodFociPerCell, 'IndividualMeanInt'))';
                        fociResults.GoodFociSumIntensity=(extractfield(fociResults.GoodFociPerCell, 'SumOfInt'))';
                        % fociResults.GoodFociMolPerFocus=(extractfield(fociResults.GoodFociPerCell, 'MoleculesPerFocus'))';
                        %fociResults.GoodmoreCbc=GoodFociResults.moreCbC;
                
                        %[BadFociResults.SingleCell, BadFociResults.moreCbC]=CellbyCellFoci(myDapiMask, BadOnesdilatedFociMask, thisFociImageOriginal, bkIntensity, QB, masterFolder, fociSettings,thisName);
                        BadFociResults.SingleCell=SCanalysis(myDapiMask, BadOnesdilatedFociMask, thisFociImageOriginal);
                        fociResults.BadFociPerCell=BadFociResults.SingleCell;
                        fociResults.BadFociMeanIntensity=(extractfield(fociResults.BadFociPerCell, 'IndividualMeanInt'))';
                        fociResults.BadFociSumIntensity=(extractfield(fociResults.BadFociPerCell, 'SumOfInt'))';
                        % fociResults.BadFociMolPerFocus=(extractfield(fociResults.BadFociPerCell, 'MoleculesPerFocus'))';
                        %fociResults.BadmoreCbc=BadFociResults.moreCbC;
                        
                        %% Create Results Images for Good and Bad foci
                       
                        redImage=uint8(imadjust(fociImage, stretchlim(fociImage, [0.01 0.999]))*255);
                        GoodgreenImage=uint8(imdilate(edge(GoodFociMaskdilated, 'sobel'),strel('disk',1))*255);
                        blueImage=uint8(imdilate(edge(myDapiMask, 'sobel'),strel('disk',1))*255);
                        fociResults.GoodFocirgbImage=cat(3,redImage, GoodgreenImage, blueImage);
                   
                        BadgreenImage=uint8(imdilate(edge(BadOnesdilatedFociMask, 'sobel'),strel('disk',1))*255);
                        fociResults.BadFocirgbImage=cat(3,redImage, BadgreenImage, blueImage);
                        
                        excgreenImage=uint8(imdilate(edge(excOnesdilatedFociMask, 'sobel'),strel('disk',1))*255);
                        fociResults.ExcFocirgbImage=cat(3,redImage, excgreenImage, blueImage);
                
                        fociResults.AllFociBBImage=allFociBBImage;
                   else
        % 
                        fociResults=fociResults;
                   end
        
            else
                disp('no cells in this image');   
                overlayImage=zeros(size(thisFociImageOriginal));
        end

        
end

