%clc;
%clear all;
addpath('G:\databases\MIP\Module1.2_FeatureExtractionSelection_Data');
ref=imread('Tumor_26.png');
figure;imshow(ref);
[x1,y1]=ginput(3);
close all
r1=ref(uint8(x1(1)),uint8(y1(1)),1);
r2=ref(uint8(x1(1)),uint8(y1(1)),2);
r3=ref(uint8(x1(1)),uint8(y1(1)),3);
b1=ref(uint8(x1(2)),uint8(y1(2)),1);
b2=ref(uint8(x1(2)),uint8(y1(2)),2);
b3=ref(uint8(x1(2)),uint8(y1(2)),3);
g1=ref(uint8(x1(3)),uint8(y1(3)),1);
g2=ref(uint8(x1(3)),uint8(y1(3)),2);
g3=ref(uint8(x1(3)),uint8(y1(3)),3);
label = zeros(size(ref,1), size(ref,2));
table = zeros(size(ref,1)*size(ref,1),4);
for i=1:size(ref,1)
    for j=1:size(ref,2)
%         dist1 = pdist2(double(ref(i, j, 1)), double(r1)) + pdist2(double(ref(i, j, 2)), double(g1)) ...
%             + pdist2(double(ref(i, j, 3)), double(b1));
%         dist2 = pdist2(double(ref(i, j, 1)), double(r3)) + pdist2(double(ref(i, j, 2)), double(g2)) ...
%             + pdist2(double(ref(i, j, 3)), double(b2));
%         dist3 = pdist2(double(ref(i, j, 1)), double(r3)) + pdist2(double(ref(i, j, 2)), double(g3)) ...
%             + pdist2(double(ref(i, j, 3)), double(b3));
        dist1 = sqrt(((double(ref(i, j, 1))) - double(r1)).^2 + ((double(ref(i, j, 2))) - double(g1)).^2 ...
            + ((double(ref(i, j, 3))) - double(b1)).^2);
        dist2 = sqrt(((double(ref(i, j, 1))) - double(r2)).^2 + ((double(ref(i, j, 2))) - double(g2)).^2 ...
            + ((double(ref(i, j, 3))) - double(b2)).^2);
        dist3 = sqrt(((double(ref(i, j, 1))) - double(r3)).^2 + ((double(ref(i, j, 2))) - double(g3)).^2 ...
            + ((double(ref(i, j, 3))) - double(b3)).^2);
        [min_val, ind] = min([dist1 dist2 dist3]);
        label(i, j) = ind;
    end
    table((i-1)*size(ref,2)+1:i*size(ref,2),1) = ref(i, :, 1);
    table((i-1)*size(ref,2)+1:i*size(ref,2),2) = ref(i, :, 2);
    table((i-1)*size(ref,2)+1:i*size(ref,2),3) = ref(i, :, 3);
    table((i-1)*size(ref,1)+1:i*size(ref,1),4) = label(i, :);
end 
table = array2table(table); %%%Use this table for classifier
segmented_images = cell(1,3);
rgb_label = repmat(label,[1 1 3]);
nColors = 3;
for k = 1:nColors
    color = ref;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end
figure;
imshow(segmented_images{1}), title('objects in cluster 1');
figure;
imshow(segmented_images{2}), title('objects in cluster 2');
figure;
imshow(segmented_images{3}), title('objects in cluster 3');
cr1=zeros(512,512);
cr2=zeros(512,512);
cr3=zeros(512,512);
for i=1:512
    for j=1:512
        labell=label(i,j);
        if labell==1
            cr1(i,j)=label(i,j);
        end
    end
end
for i=1:512
    for j=1:512
        labell=label(i,j);
        if labell==2
            cr2(i,j)=label(i,j);
        end
    end
end  
for i=1:512
    for j=1:512
        labell=label(i,j);
        if labell==3
            cr3(i,j)=label(i,j);
        end
    end
end 