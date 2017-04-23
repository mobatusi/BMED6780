function [nucleus, cytoplasm, glands] = SupervisedSegmentation(image, trainedClassifier);
% Input is an image to be segmented
% Input is the trainedClassifier
tt=image; 
% figure;imshow(tt)
table = zeros(size(tt,1)*size(tt,1),3);
for i=1:size(tt,1)
    table((i-1)*size(tt,2)+1:i*size(tt,2),1) = tt(i, :, 1);
    table((i-1)*size(tt,2)+1:i*size(tt,2),2) = tt(i, :, 2);
    table((i-1)*size(tt,2)+1:i*size(tt,2),3) = tt(i, :, 3);
end 
table=array2table(table);
yfit = trainedClassifier.predictFcn(table);
yfit=reshape(yfit,[512 512]);
yfit=yfit';
segmented_images = cell(1,3);
rgb_label = repmat(yfit,[1 1 3]);
nColors = 3;
for k = 1:nColors
    color = tt;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

% imshow(segmented_images{1}), title('objects in cluster 1');
% figure;
% imshow(segmented_images{2}), title('objects in cluster 2');
% figure;
% imshow(segmented_images{3}), title('objects in cluster 3');
c1=zeros(512,512);
c2=zeros(512,512);
c3=zeros(512,512);
for i=1:512
    for j=1:512
        labell=yfit(i,j);
        if labell==1
            c1(i,j)=yfit(i,j);
        end
    end
end
glands = c1;
for i=1:512
    for j=1:512
        labell=yfit(i,j);
        if labell==2
            c2(i,j)=yfit(i,j);
        end
    end
end  
nucleus = c1;
for i=1:512
    for j=1:512
        labell=yfit(i,j);
        if labell==3
            c3(i,j)=yfit(i,j);
        end
    end
end 
cytoplasm = c3;

end