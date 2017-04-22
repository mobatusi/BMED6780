function results = imagetraining()
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

fprintf('Loading data and selecting subset based on user input...\n');

% Ask user which dataset they want to make references
promptMessage = sprintf('Which dataset would you to use?');
            button = questdlg(promptMessage, 'Dataset', 'Dataset 1', 'Dataset 2',...
                                'Dataset 3', 'Cancel');
if strcmp(button, 'Cancel')
    return;
end
% button = 'Dataset 3';
% import all images with .png extension
folder_name = uigetdir;
allfiles = dir( fullfile(folder_name,'*.png') );%# list all *.xyz files
allfiles = {allfiles.name}';%'# file names   
% pat = {'Necrosis','Stroma','Tumor'}  ;            

%%
img_combined = [];
Table = [];
switch button
    case 'Dataset 1'        
%         testset = [];
%         % number that is equivalent to 15% of the dataset
%         n = 0.15 * length(allfiles);
%         for i = 1:n
%             % Find all images equal to i
%             files = dir( fullfile(folder_name,strcat('*_', num2str(i), '.png') ));%# list all *.xyz files
%             files = {files.name}';%'# file names 
%             % Assign these images to 3 training set clusters
%             testset = [testset,files];
% 
%             % Assign the remaining images to 3 testing set clusters  
%             Indeximgpat = contains(allfiles, files);
%             % Remove what has been added to test image
%             allfiles(Indeximgpat) = [];
%         end
%         traintest = allfiles;
        % reshape cell into 100 by 3 images
        newshape = reshape(allfiles,[100,3]);
        % Assign 15% of the data as testing set
        testset = newshape(1:15, :);
        % Assign 85% of data as testing set    
        traintest = newshape(16:end,:);


    case 'Dataset 2'
        % reshape cell into 100 by 16 images
        newshape = reshape(allfiles,[16,100]);
        % Assign 15% of the data as testing set
        testset = newshape(:,1:15);
        % Assign 85% of data as testing set    
        traintest = newshape(:,16:end);

    case 'Dataset 3'
        % reshape cell into 59 by 16 images
        newshape = reshape(allfiles,[16,59]);
        % Assign 15% of the data as testing set
        testset = newshape(:,1:9);
        % Assign 85% of data as testing set    
        traintest = newshape(:,10:end);

end 


% Separate dataset 1 into training and testing set

% Separate dataset 2 into training and testing set

% Separate dataset 3 into training and testing set

% Run image normalization on dataset 1

% Run image normalization on dataset 2

% Run image normalization on dataset 3

%% Preprocessing and image segmentation
% Run Function makingRef.m function on the dataset to obtain Table on a
% dataset
Table = Makingref()

% Run knnalgorithm.m function using Table as input and generating
% trainedclassifier
[trainedClassifier, validationAccuracy] = knnalgorithm(Table);

% color illumination normalization

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
[nucleus, cytoplasm, glands] = SupervisedSegmentation(image, trainedClassifier);

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
[Features, Names, cX, cY] = FeatureExtraction_BMED6780(L, I);
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