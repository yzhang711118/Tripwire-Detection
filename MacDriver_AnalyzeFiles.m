inFolder = uigetdir;

%Set the image type(CR2, DNG or JPEG)
%imgFiles = dir(fullfile(inFolder,'*.CR2'));
imgFiles = dir(fullfile(inFolder,'*.jpg'));

%Set the total numbers of images
nfiles = length(imgFiles);


for j = 1:nfiles
    imgName = imgFiles(j).name;
    fileName = fullfile(inFolder, imgFiles(j).name);

    % Calls the processImage function to receive hough transform matrix
    tic;
    houghVals = processImage(fileName);
    toc;
end