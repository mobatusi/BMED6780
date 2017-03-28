% function  [F, Q] = evaluate(img)
% === Evaluation of Image SEGMENTATION USING Improved Liu Algorithm =====
% This implementation of the quantitative evaluation of color image
% segmentation is based on the following paper:
%
% Borsotti, M., Campadelli, P., & Schettini, R. (1998). Quantitative 
% evaluation of color image segmentation results. Pattern Recognition Letters, 
% 19(8), 741–747. https://doi.org/10.1016/S0167-8655(98)00052-XDefinitions
% 
% 
% R(A)= number of regions having exactly area A
% I = segmented image
% NxM = image size 
% R - number of regions of the segmented image (Basophilic, Eosinophilic, Empty spaces) 
% Ai = Area of the ith region
% ei = average color error of the ith region

% The smaller the value of F(I), the better the segmentation result should be

% Normatlization factor, takes into account the size of the image
% sqrt(R), penalize segmentations that from too many regions
% 
% 
% Original Liu equation is F(I) = 1/1000(NXM)sqrt(R)sum(ei^2 / sqrt(Ai))
% Modified by BorattiF(I) = (1/ (1000*N*M))*(sqrt(R))*sum((e^2 /(1 + log(A))) +(R / A).^2);

% % ----- Example -----------
% 
% 
% ========================================

% ==================================
% Author: Dolu Obatusin
% E-mail: mobatus@gmail.com
% Georgia Institute of Technology
% March 11, 2017
% ==================================
% I = imread(img)
I = segmented_images{3};
% R = 3;% number of regions or segments
[M,N,R] = size(I);
A = M * N;

r = [255 0 0];
g = [0 255 0];
b = [0 0 255];
rgb = [r ;g; b];

img_size = (1/ (1000*N*M));
region_penalty = sqrt(R);
e = 0;
% e = zeros(3,1);
non_hom_penalty = 0;
Area = zeros(3,1);
for j = 1:R
X = segmented_images{j};
%     for i = 1: R
        h = imhist(X(:,:,j));
        h2 = imhist(rgb(:,j));
        e = e + norm(h -h2);
%     end
    A = length((find(X(:,:,1)  > 0)));
    Area(j) = A;
    non_hom_penalty = non_hom_penalty + e.^2 / A;
end

%%

F = img_size * region_penalty * non_hom_penalty;
sprintf('F = %.4f',F)

RA = 0; % R(A) is the number of regions having exactly area A
for A = 1:max(Area)
   ra = find(Area == A, 1);
   if isempty(ra)
       ra = 0;
   else
       ra = length(find(Area == A)); 
   end
   
   RA = RA + ra.^(1 + 1/A); 
end

region_freq = sqrt(RA);
F_prime = img_size * region_freq * non_hom_penalty;
sprintf('F_prime = %.4f',F_prime)

Qpam = 0;
e = 0;
for i = 1 : R
    X = segmented_images{j};
%     for i = 1: R
        h = imhist(X(:,:,i));
        h2 = imhist(rgb(:,i));
        e = e + norm(h -h2);
%     end
    A = length((find(X(:,:,1)  > 0)));

    ra = length(find(Area == A));
    if isempty(ra)
       ra = 0;
    else
       ra = length(find(Area == A)); 
    end
    
    Area(j) = A;
    Qpam = Qpam + ((e.^2 / (1 + log(A))) + (ra / A).^2);
end
 
Q = img_size*region_penalty*Qpam ;
sprintf('Q  = %.4f', Q)

% end