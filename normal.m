function normimg =  normal(folder, selectedImage,button,reply2)
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
% num = the number of images to normalize. Default is all the images a
% directory folder
%%mkdir(dest_folder)

if nargin < 3
   button = 'Dataset 1';
   reply2 = 'One Image';
% else
%    f = warndlg('You need to enter at least the folder path and image', 'Need more inputs');
end

if exist(folder, 'dir') ~=7
        message = sprintf('Error: folder does not exist:\n%s', folder);
        uiwait(warndlg(message));
        return;
end



% Create a folder to save normalized images
try
dest_folder = strcat(folder,'/','normalize')
mkdir(dest_folder)
catch ME
    if (strcmp(ME.identifier,'Warning: Directory already exists.'))
        warning('A folder already exists in the directory.');
        message = sprintf('Do you wish to continue?');
        reply = questdlg(message, 'Run Function?', 'OK','Cancel', 'OK');
        if strcmpi(reply, 'Cancel')
            % User canceled so exit.
            return;
        end
    end
    rethrow(ME)
end
%%
img = zeros(512,512,3);
% Select the image in the contrast with the largest contrast
% Udeally this should call on a function that figures out which image has
% the largest contrast

% Need to write function to find the image with the highest contrast.
% going with random image in folder for now
fullimagepath = dir(fullfile(folder,'*.png') ) ;
fullimagepath = {fullimagepath.name}';   
refimg = strcat(folder,fullimagepath{7});
    
target = imread(refimg);
target = rgb2lab(target);
ltarmean = mean2(target(:,:,1));
atarmean = mean2(target(:,:,2));
btarmean = mean2(target(:,:,3));
ltarstd = std2(target(:,:,1));
atarstd = std2(target(:,:,2));
btarstd = std2(target(:,:,3));
% srcFiles = dir(folder_name);
%%
switch reply2
        case 'One Image'     

        srcFiles = selectedImage;
        case 'All images'        
        switch button
                case 'Dataset 1'       

                srcFiles = selectedImage;
                case 'Dataset 2'        

                srcFiles = reshape(selectedImage, [1360,1]);
                case 'Dataset 3'        
                srcFiles = reshape(selectedImage, [800,1]);

        end
%         srcFiles = reshape(selectedImage, [1360,1]);        
end
for i = 1 : length(srcFiles)
    disp(i);
    filename = strcat(folder,srcFiles{i});
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
    normimg = lab2rgb(img);
%     imwrite(img1, strcat(dest_folder,'/',srcFiles{i}))
end
end