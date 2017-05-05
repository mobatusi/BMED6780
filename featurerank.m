clc;
clear all;
close all;

addpath('G:\databases\MIP\Module1.2_FeatureExtractionSelection_Data');


%offsets = [0 1; -1 1; -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1];

X = zeros(300,5);
labels = zeros(300,1);
for i=1:100
    image = rgb2gray(imread(strcat('Necrosis_',num2str(i),'.png')));
    labels(i,1) = 1;
    offsets = [0 1; 0 2; 0 3; 0 4; 0 5]; 
    C = graycomatrix(image, 'Offset', offsets, 'NumLevels', 64);
    stats = graycoprops(C);
    X(i,1) = sum(stats.Contrast)/5;
    X(i,2) = sum(stats.Energy)/5;
    X(i,3) = entropy(image);
    X(i,4) = sum(stats.Homogeneity)/5;
    %%%%GLCM Correlation
    X(i,5) = sum(stats.Correlation)/5;
end
for i=101:200
    image = rgb2gray(imread(strcat('Stroma_',num2str(i-100),'.png')));
    labels(i,1) = 2;
    offsets = [0 1; 0 2; 0 3; 0 4; 0 5]; 
    C = graycomatrix(image, 'Offset', offsets, 'NumLevels', 64);
    stats = graycoprops(C);
    X(i,1) = sum(stats.Contrast)/5;
    X(i,2) = sum(stats.Energy)/5;
    X(i,3) = entropy(image);
    X(i,4) = sum(stats.Homogeneity)/5;
    %%%%GLCM Correlation
    X(i,5) = sum(stats.Correlation)/5;
end
for i=201:300
    image = rgb2gray(imread(strcat('Tumor_',num2str(i-200),'.png')));
    labels(i,1) = 3;
    offsets = [0 1; 0 2; 0 3; 0 4; 0 5]; 
    C = graycomatrix(image, 'Offset', offsets, 'NumLevels', 64);
    stats = graycoprops(C);
    X(i,1) = sum(stats.Contrast)/5;
    X(i,2) = sum(stats.Energy)/5;
    X(i,3) = entropy(image);
    X(i,4) = sum(stats.Homogeneity)/5;
    %%%%GLCM Correlation
    X(i,5) = sum(stats.Correlation)/5;
end
