function [Features, Names, cX, cY]  = imagetraining()
% Description
% This function will generate all the mat files that are needed for
% training the images for all datasets. Essentially this mat file will
% contained trainedclassifier for dataset 1,2,3 including any other
% dependencies. The pipeline will call upon variables from this mat file

% Methods are taken from: 
% Belsare, A. D., & Mushrif, M. M. (2012). HISTOPATHOLOGICAL IMAGE ANALYSIS 
% USING IMAGE PROCESSING TECHNIQUES : AN OVERVIEW. Signal & Image Processing, 3(4), 23–36.
 
% parameters:
% folder
% selectedImage 
% button
% reply2

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
		% Read standard MATLAB demo image.
	% 	fullImageFileName = 'peppers.png';
	% Ask user which dataset they want to make references
    promptMessage = sprintf('Which dataset do you want to use?');
    button = questdlg(promptMessage, 'Dataset', 'Dataset 1', 'Dataset 2',...
                                'Dataset 3', 'Cancel');
    if strcmp(button, 'Cancel')
        return;
    end
if strcmpi(reply2, 'One Image')

	originalFolder = pwd; 

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
%     cd(originalFolder);



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
%  Magee et al (2009). Colour Normalisation in Digital Histopathology Images. 
%  Optical Tissue Image Analysis in Microscopy, Histopathology and Endoscopy (MICCAI Workshop)
normimg = normal(folder, selectedImage, button,reply2);
% Run image normalization on dataset 2

% Run image normalization on dataset 3

%% Preprocessing and image segmentation
% Zhang et al (2008). Image segmentation evaluation: A survey of unsupervised methods. 
% Unnikrishnan,et al. (2007). Toward objective evaluation of image segmentation algorithms. 

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
Table = Makingref();

%Uses linear discriminant to mask tissue pixels from background/glass.
% Mask = ForegroundDiscriminant(I, W)

% Run knnalgorithm.m function using Table as input and generating
% trainedclassifier
[trainedClassifier, ~] = knnalgorithm(Table);

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
[nucleus, ~, ~] = SupervisedSegmentation(normimg, trainedClassifier);

%% Feature extraction & selection
% Gurcan et al, (2009). Histopathological image analysis: a review. 
% Kothari, et al (2014). Histological Image Feature Mysis: a review. 
% Kothari, et al (2014). Histological Image Feature Mining Reveals Emergent Diagnostic Properties for Renal Cancer. 
% Boucheron, L. E. (2008). Object- and Spatial-Level Quantitative Analysis of Multispectral Histopathology Images for Detection and Characterization of Cancer

% Color 
% Morphology such as shape and topology (after segmenting stains based on methods developed in Module 1)
% Texture such as wavelet, GLCM, and fractal
% intensity based

% Lineaer, Non linear feature Reduction

% use Segmented images and original image as input in feature extraction

[Features, Names, cX, cY] = FeatureExtraction_BMED6780(nucleus, normimg);
% Select and Rank useful features

%% Disease detection, classification, & post Processing
%  Bellazzi et al, (2006). Predictive data mining in clinical medicine: Current issues and guidelines. 
%  F. Pereira et al, "Machine learning classifiers and fMRI: a tutorial overview,"
%  J. Kong et al, "Computer-aided evaluation of neuroblastoma on whole-slide histology images: 
%  Classifying grade of neuroblastic differentiation," 

% SVM 
%  Develop two cross-validation schemes (or internal validation) by training the classifiers using the training dataset
    % N-iterations of m-fold cross-validation
    % Leave-one-out cross-validation or bootstrapping for classifier optimization [13, 14]
%  Develop four performance metrics to evaluate your predictive model performance when applying to test dataset (i.e., external validation)
    % Area Under the Curve (AUC)
    % Matthews Correlation Coefficient (MCC)
    % F-score
    % Accuracy [21]

% KNN
%  Develop two cross-validation schemes (or internal validation) by training the classifiers using the training dataset
    % N-iterations of m-fold cross-validation
    % Leave-one-out cross-validation or bootstrapping for classifier optimization [13, 14]
%  Develop four performance metrics to evaluate your predictive model performance when applying to test dataset (i.e., external validation)
    % Area Under the Curve (AUC)
    % Matthews Correlation Coefficient (MCC)
    % F-score
    % Accuracy [21]
    
% Fisher discriminant analysis (MATLAB classify function)
%  Develop two cross-validation schemes (or internal validation) by training the classifiers using the training dataset
    % N-iterations of m-fold cross-validation
    % Leave-one-out cross-validation or bootstrapping for classifier optimization [13, 14]
%  Develop four performance metrics to evaluate your predictive model performance when applying to test dataset (i.e., external validation)
    % Area Under the Curve (AUC)
    % Matthews Correlation Coefficient (MCC)
    % F-score
    % Accuracy [21]

end % end pipeline function