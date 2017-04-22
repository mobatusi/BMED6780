function normal(folder_name, trainset)
% The goal of this function is to normalize the images
% This process reduces the differences in tissue samples 
% due to variation in staining and scanning conditions.

% Gurcan et al.(2009). Histopathological image analysis: a review.
% IEEE Rev Biomed Eng, 2, 147–171. https://doi.org/10.1109/RBME.2009.2034865
% Magee D.et al.(2009). Colour Normalisation in Digital Histopathology Images. 
% Optical Tissue Image Analysis in Microscopy, Histopathology and Endoscopy (MICCAI Workshop), 100–111. Retrieved from http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.157.5405
% refimg is the image that has the most contrast

% Files needed to run are:
% folder_name = dirctory where normalized images are located
% trainset = the training set that is being normalized, varies depending on
% the dataset.
%%
if exist(folder_name, 'dir') ~=7
        message = sprintf('Error: folder does not exist:\n%s', folder_name);
        uiwait(warndlg(message));
        return;
end

% Select the image in the contrast with the largest contrast
% Udeally this should call on a function that figures out which image has
% the largest contrast
refimg =  trainset{1};

% Create a folder to save normalized images
dest_folder = strcat(folder_name,'/','normalize')
mkdir(dest_folder)
%%
img = zeros(512,512,3);

target = imread(strcat(folder_name, '/',refimg));
target = rgb2lab(target);
ltarmean = mean2(target(:,:,1));
atarmean = mean2(target(:,:,2));
btarmean = mean2(target(:,:,3));
ltarstd = std2(target(:,:,1));
atarstd = std2(target(:,:,2));
btarstd = std2(target(:,:,3));
% srcFiles = dir(folder_name);
srcFiles = reshape(trainset, [1360,1]);
for i = 1 : length(srcFiles)
    disp(i);
    filename = strcat(folder_name,'/',srcFiles{i});
    image = rgb2lab(imread(filename));
    lorigmean = mean2(image(:,:,1));
    aorigmean = mean2(image(:,:,2));
    borigmean = mean2(image(:,:,3));
    lorigstd = std2(image(:,:,1));
    aorigstd = std2(image(:,:,2));
    borigstd = std2(image(:,:,3));
    lnew = (((image(:,:,1) - lorigmean)/lorigstd)*ltarstd)+ltarmean;
    anew = (((image(:,:,2) - aorigmean)/aorigstd)*atarstd)+atarmean;
    bnew = (((image(:,:,3) - borigmean)/borigstd)*btarstd)+btarmean;
    img(:,:,1) = lnew;
    img(:,:,2) = anew;
    img(:,:,3) = bnew;
    img1 = lab2rgb(img);
    imwrite(img1, strcat(folder_name,'/',srcFiles{i}))
end
end