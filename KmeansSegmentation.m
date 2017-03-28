function [output] = KMeansSegmentation(image)

%% Color-Based Segmentation Using K-Means Clustering
% This function segments an image using colors in an automated fashion using the
% L*a*b* color space and K-means clustering.
%
% This example requires Statistics and Machine Learning Toolbox(TM).
%
%input:
%image - (m x n x 3 uint8) RGB color image.
%output:
%RGB - (m x n x 3 uint8) RGB color image.
%% Step 1: Read Image
% Read in |Stroma_41.png|, which is an image of tissue stained with hemotoxylin
% and eosin (H&E) in dataset 1. This staining method helps pathologists distinguish different
% tissue types.
%image = 'Stroma_41.png';
he=imread(image);
s = strcat('H&E Image',{', '}, image);
figure;imshow(he), title(s);
text(size(he,2),size(he,1)+15,...
     'Image obatined from The Cancer Genome Atlas (TCGA)', ...
     'FontSize',7,'HorizontalAlignment','right');
 
%% Step 2: Convert Image from RGB Color Space to L*a*b* Color Space
% How many colors do you see in the image if you ignore variations in
% brightness?  There are three colors: white, blue, and pink.  Notice how easily
% you can visually distinguish these colors from one another.  The L*a*b* color
% space (also known as CIELAB or CIE L*a*b*) enables you to quantify these
% visual differences.
%
% The L*a*b* color space is derived from the CIE XYZ tristimulus values.  The
% L*a*b* space consists of a luminosity layer 'L*', chromaticity-layer 'a*'
% indicating where color falls along the red-green axis, and chromaticity-layer
% 'b*' indicating where the color falls along the blue-yellow axis. All of the
% color information is in the 'a*' and 'b*' layers. You can measure the
% difference between two colors using the Euclidean distance metric.
%
% Convert the image to L*a*b* color space using |makecform| and |applycform|.

% Create a color transformation structure
% Standard computer monitor RGB values 
% Convert image to L*a*b* color space
% L* represents brightness and has range from 0 to 100. 
% a* represents degree of red-green, has range from -100 to 100. 
% Positive value for redness, and negative value for greenish. 
% b* represents degree of  blue-yellow, has the same range as a*

cform = makecform('srgb2lab'); % Create a color transformation structure
lab_he = applycform(he,cform); %  converts the color values in the (original)
%image to the color space specified in the color transformation structure,cform.

%% Step 3: Classify the Colors in 'a*b*' Space Using K-Means Clustering
% Clustering is a way to separate groups of objects.  K-means clustering treats
% each object as having a location in space. It finds partitions such that
% objects within each cluster are as close to each other as possible, and as far
% from objects in other clusters as possible. K-means clustering requires that
% you specify the number of clusters to be partitioned and a distance metric to
% quantify how close two objects are to each other.
%
% Since the color information exists in the 'a*b*' space, your objects are
% pixels with 'a*' and 'b*' values.  Use |kmeans| to cluster the objects into
% three clusters using the Euclidean distance metric.

ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',10);
%% Step 4: Label Every Pixel in the Image Using the Results from KMEANS
% For every object in your input, |kmeans| returns an index corresponding to a
% cluster. The |cluster_center| output from |kmeans| will be used later in the
% example. Label every pixel in the image with its |cluster_index|.

pixel_labels = reshape(cluster_idx,nrows,ncols);
figure;imshow(pixel_labels,[]), title('image labeled by cluster index');

%% Step 5: Create Images that Segment the H&E Image by Color.
% Using |pixel_labels|, you can separate objects in |Stroma_41.png| by color,
% which will result in three images.

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
%% Step 6: Segment the Nuclei into a Separate Image
% Notice that there are dark and light blue objects in one of the clusters.
% You can separate dark blue from light blue using the 'L*' layer in the
% L*a*b* color space. The cell nuclei are dark blue.
%
% Recall that the 'L*' layer contains the brightness values of each color.
% Find the cluster that contains the blue objects. Extract the brightness
% values of the pixels in this cluster and threshold them using |im2bw|.
%
% You must programmatically determine the index of the cluster containing
% the blue objects because |kmeans| will not return the same |cluster_idx|
% value every time.  You can do this using the |cluster_center| value,
% which contains the mean 'a*' and 'b*' value for each cluster. The blue
% cluster has the smallest cluster_center value (determined
% experimentally).
mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value);
blue_cluster_num = idx(1);

L = lab_he(:,:,1);
blue_idx = find(pixel_labels == blue_cluster_num);
L_blue = L(blue_idx);
is_light_blue = im2bw(L_blue,graythresh(L_blue));

%%
% Use the mask |is_light_blue| to label which pixels belong to the blue
% nuclei. Then display the blue nuclei in a separate image.

nuclei_labels = repmat(uint8(0),[nrows ncols]);
nuclei_labels(blue_idx(is_light_blue==false)) = 1;
output = nuclei_labels;
nuclei_labels = repmat(nuclei_labels,[1 1 3]);
blue_nuclei = he;
blue_nuclei(nuclei_labels ~= 1) = 0;
figure;imshow(blue_nuclei), title('blue nuclei');
end