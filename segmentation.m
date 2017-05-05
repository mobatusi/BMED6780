function [ BW , maskedImage] = segmentation( X , s)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%  s will be used to adjust the sensitivity of the image


if nargin < 2
    
    s = 0.170000;
end
% Convert from RGB to grayscale.
X = rgb2gray(X);

% Threshold image - global threshold
BW = imbinarize(X);

% Active contour using Chan-Vese over 100 iterations
iterations = 100;
BW = activecontour(X, BW, iterations, 'Chan-Vese');

% Threshold image - adaptive threshold
BW = imbinarize(X, 'adaptive', 'Sensitivity', s, 'ForegroundPolarity', 'dark');

% Create masked image.
maskedImage = X;
maskedImage(~BW) = 0;
end

