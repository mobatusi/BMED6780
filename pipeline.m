function results = pipeline(image)
%% This function is used to run inputs from the GUI and to classify the image selected by user

%% Load pre-trained data

%% Perform feature extraction on new image
[Features, Names, cX, cY] = FeatureExtraction_BMED6780(nucleus, image)
%% Run classifiers on new image

%% Return result to GUI app 

%% Prompt user that run is completed

end % end pipeline function