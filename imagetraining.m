function results = imagetraining(image)
% Description
% This function will generate all the mat files that are needed for
% training the images for all datasets. Essentially this mat file will
% contained trainedclassifier for dataset 1,2,3 including any other
% dependencies. The pipeline will call upon variables from this mat file
% Last Edit: 04/17/17 by Dolu Obatusin
fprintf('Loading data and selecting subset based on user input...\n');
cd('~/google_drive/phd/bmed8813/group_project/data');

% Run Function makingRef.m function on the dataset to obtain Table on a
% dataset
Table = Makingref()
% Run knnalgorithm.m function using Table as input and generating
% trainedclassifier
[trainedClassifier, validationAccuracy] = knnalgorithm(Table);
% Perform Image Segmentation using trained classifier and image as input in
% function SupervisedSegmentation
[nucleus, cytoplasm, glands] = SupervisedSegmentation(image, trainedClassifier);
% use Segmented images and original image as input in feature extraction
% function
% [Features, Names, cX, cY] = FeatureExtraction_BMED6780(L, I, K, FSDBins,...
%                                                         Delta, M)
[Features, Names, cX, cY] = FeatureExtraction_BMED6780(L, I);
% Select and Rank useful features

% Perform cross validation on training set and iterate until convergence

% Save workspace as mat file






end % end pipeline function