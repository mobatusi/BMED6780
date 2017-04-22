function shapes = Featureextraction_Final()
% files = dir( fullfile(folder_name,'*.png') );%# list all *.xyz files
% contfolder = '\Users\aojag\OneDrive - Georgia Institute of Technology\Med Image Processing Project\Dataset\dataset2\Module2_PredictionModeling_Data\TCGA_KIRC_Grading_Survival\Normalized'; 

contfolder = uigetdir;

if exist(contfolder, 'dir') ~=7
        message = sprintf('Error: folder does not exist:\n%s', contfolder);
        uiwait(warndlg(message));
        return;
end
filepattern = fullfile(contfolder, '*.png');

imgfiles = dir(filepattern);
load('Dataset2_TrainedClassifier_Final.mat');
 %%

for i=1:length(imgfiles);
    disp(i);
    fullfilename = imgfiles(i).name;
tt = imread(strcat(contfolder, '/',fullfilename)); 
%figure;imshow(tt);
table = zeros(size(tt,1)*size(tt,1),3);
for j=1:size(tt,1)
    table((j-1)*size(tt,2)+1:j*size(tt,2),1) = tt(j, :, 1);
    table((j-1)*size(tt,2)+1:j*size(tt,2),2) = tt(j, :, 2);
    table((j-1)*size(tt,2)+1:j*size(tt,2),3) = tt(j, :, 3);
end 
table=array2table(table);
yfit = trainedClassifier.predictFcn(table);
yfit=reshape(yfit,[512 512]);
yfit=yfit';

shapes(i,:)=featextract(yfit);

end
end