% Create some sample data
load ('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_26May2023_siRNA/FociAnalysis/GFP_DistributionResults_July_t/Untreated_Zeocin00500_53BP1_Distribution.mat');
data=DistributionResults.Tot;
numBins=3;
[histogram, binEdges] = histcounts(data, numBins);





data=DistributionResults.Tot;
% Create a histogram with specified number of bins
numBins = 3;
[histogram, binEdges] = histcounts(data, numBins);

% Initialize a cell array to store indices for each bin
binIndices = cell(1, numBins);

% Iterate through each bin
for binIdx = 1:numBins
    % Find indices of elements within the current bin
    indicesInBin = find(data >= binEdges(binIdx) & data < binEdges(binIdx + 1));
    
    % Store indices in the cell array
    binIndices{binIdx} = indicesInBin;
end

% Display the indices for each bin
for binIdx = 1:numBins
    fprintf('Bin %d: Indices: ', binIdx);
    fprintf('%d ', binIndices{binIdx});
    fprintf('\n');
end
