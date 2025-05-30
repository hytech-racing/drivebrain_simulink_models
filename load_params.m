% Get a list of all .mat files in the folder

fullPath = mfilename("fullpath");

currentDir = fileparts(fullPath);

folderPath = fullfile(currentDir, 'shared_data');
matFiles = dir(fullfile(currentDir, 'shared_data', '*.mat'));

% Loop through each file and load it
for k = 1:length(matFiles)
    % Full path to the .mat file
    filePath = fullfile(folderPath, matFiles(k).name);

    % Display which file is being loaded
    fprintf('Loading %s\n', filePath);

    load(filePath);
end