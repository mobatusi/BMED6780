function [Features, Names, cX, cY]  = imagetraining()
% Description
% This function will generate all the mat files that are needed for
% training the images for all datasets. Essentially this mat file will
% contained trainedclassifier for dataset 1,2,3 including any other
% dependencies. The pipeline will call upon variables from this mat file

% Methods refereced from 
% Belsare, A. D., & Mushrif, M. M. (2012). HISTOPATHOLOGICAL IMAGE ANALYSIS 
% USING IMAGE PROCESSING TECHNIQUES : AN OVERVIEW. Signal & Image Processing, 3(4), 23–36.
% Last Edit: 04/17/17 by Dolu Obatusin
%% Separate images in to training and testing set
clc
clear all
% fprintf('Loading data and selecting subset based on user input...\n');
% ver % Display user's toolboxes in their command window.

% Introduce the demo, and ask user if they want to continue or exit.
message = sprintf('This function will be used to train images\nDo you wish to continue?');
reply = questdlg(message, 'Run Function?', 'OK','Cancel', 'OK');
if strcmpi(reply, 'Cancel')
	% User canceled so exit.
	return;
end
% Ask user if they want to use a demo image or their own image.
message = sprintf('Do you want to train more than one image,\nOr pick only one image?');
reply2 = questdlg(message, 'Which Image?', 'All images','One Image', 'Demo');
% Open an image.

% Ask user which dataset they want to make references
% promptMessage = sprintf('Which dataset do you want to use?');
%             button = questdlg(promptMessage, 'Dataset', 'Dataset 1', 'Dataset 2',...
%                                 'Dataset 3', 'Cancel');
% if strcmp(button, 'Cancel')
%     return;
% end
%% If only one image
if strcmpi(reply2, 'One Image')
		% Read standard MATLAB demo image.
	% 	fullImageFileName = 'peppers.png';
	% Ask user which dataset they want to make references
    promptMessage = sprintf('Which dataset do you want to use?');
    button = questdlg(promptMessage, 'Dataset', 'Dataset 1', 'Dataset 2',...
                                'Dataset 3', 'Cancel');
    if strcmp(button, 'Cancel')
        return;
    end
	originalFolder = pwd; 
%     folder = 'C:\Program Files\MATLAB\R2010a\toolbox\images\imdemos'; 
% 	if ~exist(folder, 'dir') 
% 			folder = pwd; 
% 	end 
% 	cd(folder); 
	% Browse for the image file. 
	[baseFileName, folder] = uigetfile('*.*', 'Specify an image file'); 
	fullimagepath = fullfile(folder, baseFileName); 
    selectedImage = {baseFileName};
	% Set current folder back to the original one. 
	cd(originalFolder);
% 	selectedImage = 'My own image'; % Need for the if threshold selection statement later.
else % If more than one image
    
    % button = 'Dataset 3';
    % import all images with .png extension
    [baseFileName, folder]  = uigetfile('*.*', 'Specify an image file'); 
    allfiles = dir( fullfile(folder,'*.png') );%# list all *.xyz files
    allfiles = {allfiles.name}';%'# file names   
    % pat = {'Necrosis','Stroma','Tumor'}  ;            
    cd(originalFolder);



%% Separate dataset 1,2 and 3 into training and testing set
    img_combined = [];
    Table = [];
    switch button
    % Separate dataset 1 into training and testing set
        case 'Dataset 1'        
            % reshape cell into 100 by 3 images
            newshape = reshape(allfiles,[100,3]);
            % Assign 15% of the data as testing set
            testset = newshape(1:15, :);
            % Assign 85% of data as testing set    
            trainset = newshape(16:end,:);

    % Separate dataset 2 into training and testing set

        case 'Dataset 2'
            % reshape cell into 100 by 16 images
            newshape = reshape(allfiles,[16,100]);
            % Assign 15% of the data as testing set
            testset = newshape(:,1:15);
            % Assign 85% of data as testing set    
            trainset = newshape(:,16:end);

    % Separate dataset 3 into training and testing set
        case 'Dataset 3'
            % reshape cell into 59 by 16 images
            newshape = reshape(allfiles,[16,59]);
            % Assign 15% of the data as testing set
            testset = newshape(:,1:9);
            % Assign 85% of data as testing set    
            trainset = newshape(:,10:end);

    end 
selectedImage = trainset;
end
%% Run color normalization on image(s)
normimg = normal(folder, selectedImage, button,reply2);
% Run image normalization on dataset 2

% Run image normalization on dataset 3

%% Preprocessing and image segmentation

% Color Normalization
% output is saved in a folder within the directory called normalize
% normal(folder_name, trainset);

%Bouguer-Lambert-Beer transformation of RGB color values.


% Color Deconvolution
%This implements the Ruifrok and Johnston algorithm for color deconvolution. An example
%calibration matrix for hematoxylin and eosin images - M = [0.650 0.072 0; 0.704 0.990 0;
%  0.286 0.105 0];
%  
 
% Run Function makingRef.m function on the dataset to obtain Table on a
% dataset

%Uses linear discriminant to mask tissue pixels from background/glass.
% Mask = ForegroundDiscriminant(I, W)
Table = Makingref()

% Run knnalgorithm.m function using Table as input and generating
% trainedclassifier
[trainedClassifier, validationAccuracy] = knnalgorithm(Table);

% color illumination normalization
% RGB = LAB2RGB(LAB)
%Converts RGB image to LAB colorspace.

% Normalized = Reinhard(I, TargetMu, TargetSigma, W, Mask)
%Performs Reinhard color normalization to map input image statistics to
%target image statistics in LAB color space.

% Smoothing

% Denoising

% Enhancement

% Thresholding

% Edge detection

% region based

% active contour

% clustering

% Perform Image Segmentation using trained classifier and image as input in
% function SupervisedSegmentation
[nucleus, cytoplasm, glands] = SupervisedSegmentation(normimg, trainedClassifier);

%% Feature extraction & selection

% Morphometry

% Color

% textural

% intensity based

% Morphological

% Lineaer, Non linear feature Reduction

% use Segmented images and original image as input in feature extraction
% function
% [Features, Names, cX, cY] = FeatureExtraction_BMED6780(L, I, K, FSDBins,...
%                                                         Delta, M)
[Features, Names, cX, cY] = FeatureExtraction_BMED6780(nucleus, normimg);
% Select and Rank useful features

%% Disease detection, classification, & post Processing
% Supervised

% Unsupervised

% Neural Networks

% k-nearest neighbors

% Fuzzy systems

% Morphological features

% Perform cross validation on training set and iterate until convergence

% Save workspace as mat file






end % end pipeline function