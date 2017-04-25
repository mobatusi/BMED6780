function normimg =  normal2()
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

% if nargin < 3
%    button = 'Dataset 1';
%    reply2 = 'One Image';
% % else
% %    f = warndlg('You need to enter at least the folder path and image', 'Need more inputs');
% end
% 
% if exist(folder, 'dir') ~=7
%         message = sprintf('Error: folder does not exist:\n%s', folder);
%         uiwait(warndlg(message));
%         return;
% end
% 
% 
% 
% % Create a folder to save normalized images
% try
% dest_folder = strcat(folder,'/','normalize')
% mkdir(dest_folder)
% catch ME
%     if (strcmp(ME.identifier,'Warning: Directory already exists.'))
%         warning('A folder already exists in the directory.');
%         message = sprintf('Do you wish to continue?');
%         reply = questdlg(message, 'Run Function?', 'OK','Cancel', 'OK');
%         if strcmpi(reply, 'Cancel')
%             % User canceled so exit.
%             return;
%         end
%     end
%     rethrow(ME)
% end
%%
% button = 'Dataset 3';
% import all images with .png extension
% [baseFileName, folder]  = uigetfile('*.*', 'Specify an image file'); 
% allfiles = dir( fullfile(folder,'*.png') );%# list all *.xyz files
% allfiles = {allfiles.name}';%'# file names   

%% Step 1:  Read the Image into the Workspace
% Read and display the grayscale image rice.png.
% I = imread(strcat(folder, allfiles{120}));
I = imread(strcat(folder, allfiles{120}));
figure;
imshow(I)
%% Step 2: Preprocess the Image to Enable Analysis
% The example calls the strel function to create a disk-shaped structuring element with a radius of 15.
background = imopen(I,strel('disk',15));
% The pixels at the bottom of the image appear at the front of the surface plot
% The highest part of the curve indicates that the highest pixel values of background occur near the middle rows of the image.
% The lowest pixel values occur at the bottom of the image.
figure
surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
set(gca,'ydir','reverse');

% Subtract the background approximation image, background, from the original image, I, and view the resulting image.
I2 = I - background;
figure
imshow(I2)

% Use imadjust to increase the contrast of the processed image I2 by saturating 
% 1% of the data at both low and high intensities and by stretching the intensity values to fill the uint8 dynamic range.

I3 = imadjust(rgb2gray(I2));
imshow(I3);
% Create a binary version of the processed image so you can use toolbox functions for analysis. 
bw = imbinarize(I3);
bw = bwareaopen(bw, 50);
imshow(bw)

% Step 3: Perform Analysis of Objects in the Image
cc = bwconncomp(bw, 4)
cc.NumObjects


% View the rice grain that is labeled 50 in the image.
grain = false(size(bw));
grain(cc.PixelIdxList{50}) = true;
imshow(grain);

% Visualize all the connected components in the image.
% First, create a label matrix, and then display the label matrix as a pseudocolor indexed image. 
% Use labelmatrix to create a label matrix from the output of bwconncomp.
% Use label2rgb to choose the colormap, the background color, and how objects in the label matrix map to colors in the colormap.

labeled = labelmatrix(cc);
RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle');
imshow(RGB_label)

% Compute the area of each object in the image using regionprops. Each rice grain is one connected component in the cc structure.
% 
graindata = regionprops(cc, 'basic');
graindata(50).Area

% Create a vector grain_areas to hold the area measurement of each object (rice grain).
grain_areas = [graindata.Area];

% Find the rice grain with the smallest area.
[min_area, idx] = min(grain_areas)

grain = false(size(bw));
grain(cc.PixelIdxList{idx}) = true;
imshow(grain);

% Use the histogram command to create a histogram of rice grain areas.
figure
histogram(grain_areas)
title('Histogram of Rice Grain Area');




end