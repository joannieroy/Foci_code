%% Results_visualisation

%% Path

masterFolder='C:\Users\joann\OneDrive - Sante et Services sociaux\Christos\Data\DNAdamage_IF\Good_Replicates\2umCW_Laser\20260901_H_2um_4h_H2AX_53PB1\53BP1GFP_ResultstoGraph';

files = dir(fullfile(masterFolder, '*.mat'));
data = struct();

for k = 1:numel(files)
    [~, name] = fileparts(files(k).name);
    name = matlab.lang.makeValidName(name);     % handles spaces, leading digits, etc.
    data.(name) = load(fullfile(files(k).folder, files(k).name));
end


%% Looking at the distribution

names = fieldnames(data);
figure
for k = 1:numel(names)
    subplot(2,2,k)
    histogram(data.(names{k}).ResultsNumber.NumberofFociPerCellGoodAndBad)   % replace myVariable with your variable name
    title(names{k}, 'Interpreter', 'none')
end

%% 
names = fieldnames(data);
nFiles = numel(names);
nCells = zeros(nFiles,1); sds = nan(nFiles,1);

means = nan(nFiles, 1);
figure
for k = 1:nFiles
    x = data.(names{k}).ResultsNumber.NumberofFociPerCellGoodAndBad;
    x = x(:);                                   % force a column vector

    means(k) = mean(x, 'omitnan');
    nCells(k) = numel(x);
    sds(k)    = std(x, 'omitnan');
   
    subplot(2,2,k)
    histogram(x)
    title(names{k}, 'Interpreter', 'none')
end

%T = table(names, means, 'VariableNames', {'Condition', 'MeanFociPerCell'});
T = table(names, means, sds, nCells, 'VariableNames', {'Condition','Mean','SD','N'});
writetable(T, fullfile(masterFolder, 'mean_foci_per_cell.csv'));