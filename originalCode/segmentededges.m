
load('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_18Apr2024_NuMA/Foci/NuMA_Zeo_500/NuMAmasks/Alexa647_004_C3.tif.NuMAmask.mat');
mask=NuMAmask;
% Find the boundaries
boundaries = bwboundaries(mask);

% Plot the mask and its segmented outline
figure;
imshow(mask); % Show the binary mask
hold on; % Overlay the boundary

% Loop through each boundary and plot it
for k = 1:length(boundaries)
    boundary = boundaries{k};
    % Plot each boundary as a segmented red dashed line
    plot(boundary(:,2), boundary(:,1), 'r:', 'LineWidth', 1.5);
end

hold off;
