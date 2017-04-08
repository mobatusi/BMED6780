function [Features, Names, cX, cY] = FeatExt()
%----------------------------------------------------------
% Program to read in all the images in a folder and 
% display the histograms of each color channel.
% Feb. 2011
%----------------------------------------------------------
%Extract color, shape, texture, gradient and intensity features from segmented 
%objects.
%
%inputs:
%L - (T x T float) Nuclei label image.
%I - (T x T x 3 uint 8) Color image.
%K - (scalar) Points for boundary resampling in calculating fourier 
%    descriptors. Default value 128.
%FSDBins - (scalar) number of frequency bins for calculating fourier shape
%           descriptors. Default value 6.
%Delta - (scalar) Dilation factor for expanding nuclei to capture
%        surrounding cytoplasm.
%M - (3 x 3 float) Color deconvolution matrix for deconvolving hematoxlyin
%    and eosin signals. Default value [0.650 0.072 0; 0.704 0.990 0; 0 0 0]
%
%outputs:
%Features - (N x 48 float) Matrix of features where each row is a nucleus
%           and each column is a feature.
%Names - (48-length cell string) Cell array of strings describing features.
%cX - (N x 1 float) Vector of horizontal nuclear centroid coordinates.
%cY - (N x 1 float) Vector of vertical nuclear centroid coordinates.
%
%Notes:
%Kong J, Cooper LAD, et al "Machine-based morphologic analysis of 
%glioblastoma using whole-slide pathology images uncovers clinically 
%relevant molecular correlates," PLoS One. 2013 Nov 13;8(11):e81049. 
%doi: 10.1371/journal.pone.0081049. eCollection 2013.
%
%Authors: Dolu, Nishanth, Ashkan
% Modified by Dolu Obatusin 
% Includes other feature extraction paratmets such as color, texture
% (wavelet, and GLCM, and fractal)
%----------------------------------------------------------

%Color features
% Load the configuration and set dictionary size to 20 (for fast demo)





end