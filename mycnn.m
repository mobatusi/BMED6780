function [ output_args ] = mycnn( input_args )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%   The Caffe version [1] of AlexNet, as described in [2],
%   is available to download and use for your problems. 
net = alexnet
net.Layers
% First, read the image to classify.
I = imread('peppers.png');
% This image is of size 384-by-512-by-3. You must adjust it to the size of 
% the images the network was trained on. Extract the input size of the network.
sz = net.Layers(1).InputSize
% Crop image to the input size of the network.
I = I(1:sz(1),1:sz(2),1:sz(3));
% Classify (predict the label of ) the image using AlexNet
label = classify(net, I)
figure
imshow(I)
text(10,20,char(label),'Color','white')

%%
% Transfer Learning Using Convolutional Neural Networks
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos',...
    'nndatasets','DigitDataset');
digitData = imageDatastore(digitDatasetPath,...
        'IncludeSubfolders',true,'LabelSource','foldernames');
    
% Display some of the images in the datastore.   
for i = 1:20
    subplot(4,5,i);
    imshow(digitData.Files{i});
end    
% Check the number of images in each digit category
digitData.countEachLabel
% The data contains an unequal number of images per category.
% 
% To balance the number of images for each digit in the training set, 
% first find the minimum number of images in a category.
minSetCount = min(digitData.countEachLabel{:,2})

% Divide the dataset so that each category in the training set has 494 images
% and the testing set has the remaining images from each label.
trainingNumFiles = round(minSetCount/2);
rng(1) % For reproducibility
[trainDigitData,testDigitData] = splitEachLabel(digitData,...
				trainingNumFiles,'randomize');
            
% splitEachLabel splits the image files in digitData into two new datastores, 
% trainDigitData and testDigitData. 

% Create the layers for the convolutional neural network.

layers = [imageInputLayer([28 28 1])
	 convolution2dLayer(5,20)
	 reluLayer()
	 maxPooling2dLayer(2,'Stride',2)
	 fullyConnectedLayer(10)
	 softmaxLayer()
	 classificationLayer()];
% Create the training options. Set the maximum number of epochs at 20, and 
% start the training with an initial learning rate of 0.001. 

options = trainingOptions('sgdm','MaxEpochs',20,...
	'InitialLearnRate',0.001);

% Train the network using the training set and the options you defined in the previous step.
convnet = trainNetwork(trainDigitData,layers,options);

% Test the network using the testing set and compute the accuracy.
YTest = classify(convnet,testDigitData);
TTest = testDigitData.Labels;
accuracy = sum(YTest == TTest)/numel(YTest)

% Accuracy is the ratio of the number of true labels in the test data 
% matching the classifications from classify, to the number of images in
% the test data. In this case 99.78% of the digit estimations match the 
% true digit values in the test set.
% Now, suppose you would like to use the trained network net to predict
% classes on a new set of data. Load the letters training data.

% load lettersTrainSet.mat
% XTrain contains 1500 28-by-28 grayscale images of the letters A, B, and C in a 4-D array. TTrain contains the categorical array of the letter labels.
% 
% Display some of the letter images.

figure;
for j = 1:20
    subplot(4,5,j);
    selectImage = datasample(XTrain,1,4);
    imshow(selectImage,[]);
end
% 
% The pixel values in XTrain are in the range [0 1]. 
% The digit data used in training the network net were in [0 255]; scale 
the letters data between [0 255].

XTrain = XTrain*255;
% The last three layers of the trained network net are tuned for the
% digit dataset, which has 10 classes. The properties of these layers depend 
% on the classification task. Display the fully connected layer (fullyConnectedLayer).

convnet.Layers(end-2)

% Display the last layer (classificationLayer).
convnet.Layers(end)

% These three layers must be fine-tuned for the new classification problem. 
% Extract all the layers but the last three from the trained network, net.
layersTransfer = convnet.Layers(1:end-3);
% 
% The letters data set has three classes. Add a new fully connected layer 
% for three classes, and increase the learning rate for this layer.
layersTransfer(end+1) = fullyConnectedLayer(3,...
              'WeightLearnRateFactor',10,...
	          'BiasLearnRateFactor',20);
% Add a softmax layer and a classification output layer.          
layersTransfer(end+1) = softmaxLayer();
layersTransfer(end+1) = classificationLayer();       
% 
% Create the options for transfer learning. You do not have to train for many
% epochs (MaxEpochs can be lower than before). Set the InitialLearnRate at a 
% lower rate than used for training net to improve convergence by taking smaller steps.
optionsTransfer = trainingOptions('sgdm',...
         'MaxEpochs',5,...
         'InitialLearnRate',0.000005,...
         'Verbose',true);
% Perform transfer learning 
convnetTransfer = trainNetwork(XTrain,TTrain,...
		   layersTransfer,optionsTransfer);
% Load the letters test data. Similar to the letters training data, scale the
% testing data between [0 255], because the training data were between that range.       
load lettersTestSet.mat
XTest = XTest*255; 

% Test the accuracy.
YTest = classify(convnetTransfer,XTest);
accuracy = sum(YTest == TTest)/numel(TTest)
end



