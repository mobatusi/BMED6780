he=imread('Stroma_41.png');
figure;imshow(he);
cform = makecform('srgb2lab');
lab_he = applycform(he,cform);
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',10);
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure;imshow(pixel_labels,[]), title('image labeled by cluster index');
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = he;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end
figure;imshow(segmented_images{1}), title('objects in cluster 1');
figure;imshow(segmented_images{2}), title('objects in cluster 2');
figure;imshow(segmented_images{3}), title('objects in cluster 3');
%figure;imshow(segmented_images{4}), title('objects in cluster 4');
mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value);
blue_cluster_num = idx(1);

L = lab_he(:,:,1);
blue_idx = find(pixel_labels == blue_cluster_num);
L_blue = L(blue_idx);
is_light_blue = im2bw(L_blue,graythresh(L_blue));
nuclei_labels = repmat(uint8(0),[nrows ncols]);
nuclei_labels(blue_idx(is_light_blue==false)) = 1;
nuclei_labels = repmat(nuclei_labels,[1 1 3]);
blue_nuclei = he;
blue_nuclei(nuclei_labels ~= 1) = 0;
figure;imshow(blue_nuclei), title('blue nuclei');
c1=zeros(512,512);
c2=zeros(512,512);
c3=zeros(512,512);
for i=1:512
    for j=1:512
        labell=pixel_labels(i,j);
        if labell==1
            c1(i,j)=pixel_labels(i,j);
        end
    end
end
for i=1:512
    for j=1:512
        labell=pixel_labels(i,j);
        if labell==2
            c2(i,j)=pixel_labels(i,j);
        end
    end
end  
for i=1:512
    for j=1:512
        labell=pixel_labels(i,j);
        if labell==3
            c3(i,j)=pixel_labels(i,j);
        end
    end
end 