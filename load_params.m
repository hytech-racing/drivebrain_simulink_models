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

    % Load the contents into a struct to avoid overwriting variables
    dataStruct = load(filePath);

    % Optionally assign to a variable with the same name as the file
    [~, fileBaseName, ~] = fileparts(matFiles(k).name);
    assignin('base', fileBaseName, dataStruct);
end