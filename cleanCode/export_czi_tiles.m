%% export_czi_tiles.m
% For each condition folder inside a master folder, export every tile
% (series/scene) of every .czi file as individual TIFFs, one file per
% tile per channel (Z/T planes are stored as a multipage TIFF).
% Output goes to <condition>/tiff_export/
%
% Requires Bio-Formats for MATLAB (bfmatlab) on the MATLAB path:
% https://www.openmicroscopy.org/bio-formats/downloads/

clear; clc;

%% Bio-Formats setup
% Set this to the folder containing bfmatlab (the one with bfGetPlane.m and
% bioformats_package.jar). Leave '' if bfmatlab is already on your path.
bfPath = 'C:\Users\joann\code\bfmatlab';   % e.g. 'C:\Users\you\Documents\MATLAB\bfmatlab'

if ~isempty(bfPath), addpath(bfPath); end
if isempty(which('bfGetPlane'))
    bfPath = uigetdir(pwd, 'Select the bfmatlab folder');
    if bfPath == 0, error('bfmatlab folder is required.'); end
    addpath(bfPath);
end
jarFile = fullfile(fileparts(which('bfGetPlane')), 'bioformats_package.jar');
if ~exist(jarFile, 'file')
    error('bioformats_package.jar not found next to bfGetPlane.m (%s).', jarFile);
end
if ~any(strcmp(javaclasspath('-all'), jarFile))
    javaaddpath(jarFile);
end

%% Select master folder
masterDir = uigetdir(pwd, 'Select the master folder');
if masterDir == 0, return; end

outName = 'tiff_export';

% Condition folders = subfolders of master (skip '.', '..', and exports)
d = dir(masterDir);
condDirs = d([d.isdir] & ~ismember({d.name}, {'.', '..', outName}));

for ic = 1:numel(condDirs)
    condPath = fullfile(masterDir, condDirs(ic).name);
    cziFiles = dir(fullfile(condPath, '*.czi'));
    if isempty(cziFiles), continue; end

    outDir = fullfile(condPath, outName);
    if ~exist(outDir, 'dir'), mkdir(outDir); end
    fprintf('Condition: %s (%d czi files)\n', condDirs(ic).name, numel(cziFiles));

    for ifile = 1:numel(cziFiles)
        cziPath = fullfile(condPath, cziFiles(ifile).name);
        [~, baseName] = fileparts(cziFiles(ifile).name);

        % Open reader (keep tiles as separate series, no pyramid levels)
        r = loci.formats.ChannelSeparator(loci.formats.ChannelFiller());
        r.setMetadataStore(loci.formats.MetadataTools.createOMEXMLMetadata());
        try r.setFlattenedResolutions(false); catch, end
        r.setId(cziPath);
        meta = r.getMetadataStore();

        nTiles = r.getSeriesCount();
        fprintf('  %s: %d tiles\n', cziFiles(ifile).name, nTiles);

        for s = 1:nTiles
            r.setSeries(s-1);
            nC = r.getSizeC();
            nZ = r.getSizeZ();
            nT = r.getSizeT();

            for c = 1:nC
                % Channel label: C1, C2... plus channel name if available
                chLabel = sprintf('C%d', c);
                try
                    nm = char(meta.getChannelName(s-1, c-1));
                    if ~isempty(nm)
                        nm = regexprep(nm, '[^\w\-]', '_');
                        chLabel = sprintf('C%d-%s', c, nm);
                    end
                catch
                end

                outFile = fullfile(outDir, sprintf('%s_tile%03d_%s.tif', ...
                    baseName, s, chLabel));
                if exist(outFile, 'file'), delete(outFile); end

                % Write all Z/T planes of this channel as a multipage TIFF
                for t = 1:nT
                    for z = 1:nZ
                        idx = r.getIndex(z-1, c-1, t-1) + 1;
                        plane = bfGetPlane(r, idx);   % keeps native bit depth
                        imwrite(plane, outFile, 'tif', ...
                            'WriteMode', 'append', 'Compression', 'none');
                    end
                end
            end
        end
        r.close();
    end
end

disp('Done.');