for k = 1:100
    jpgFileName = strcat('Tumor_', num2str(k), '.png');
		rawdat(:,:,:,k) = imread(jpgFileName);
end
for i=1:100
    clear c1;
    clear c2;
    clear c3;
    clear yfit;
    clear table;
    clear tt; clear color;
    clear rgb_label; clear mnl1;clear mnl2;clear mnl3;
    clear segmented_images;clear mjl1;clear mjl2;clear mjl3;
    clear cbw1; clear cbw3;clear cbw2;clear labell;clear are1,clear are2;clear are3;
    j=0;
    k=0;
    ii=0;jj=0;ij=0;ji=0;ki=0;ik=0;ih=0;hi=0;ti=0;it=0;ir=0;
tt=rawdat(:,:,:,i);
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
segmented_images = cell(1,3);
rgb_label = repmat(yfit,[1 1 3]);
nColors = 3;
for k = 1:nColors
    color = tt;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end
%figure;
%imshow(segmented_images{1}), title('objects in cluster 1');
%figure;
%imshow(segmented_images{2}), title('objects in cluster 2');
%figure;
%imshow(segmented_images{3}), title('objects in cluster 3');
c1=zeros(512,512);
c2=zeros(512,512);
c3=zeros(512,512);
for ii=1:512
    for jj=1:512
        labell=yfit(ii,jj);
        if labell==1
            c1(ii,jj)=yfit(ii,jj);
        end
    end
end
for ii=1:512
    for jj=1:512
        labell=yfit(ii,jj);
        if labell==2
            c2(ii,jj)=yfit(ii,jj);
        end
    end
end  
for ii=1:512
    for jj=1:512
        labell=yfit(ii,jj);
        if labell==3
            c3(ii,jj)=yfit(ii,jj);
        end
    end
end
thresh=0;
cbw1=bwconncomp(c1);
cbw2=bwconncomp(c2);
cbw3=bwconncomp(c3);
are1(:)=cell2mat(struct2cell(regionprops(cbw1, 'Solidity')));
are2(:)=cell2mat(struct2cell(regionprops(cbw2, 'Solidity')));
are3(:)=cell2mat(struct2cell(regionprops(cbw3, 'Solidity')));
area1=0;
area2=0;
area3=0;
k=0;
kk=0;
kkk=0;
for ij=1:size(are1,2)
    if are1(1,ij)>thresh
     area1=area1+are1(1,ij);
     k=k+1;
    end
end
for ji=1:size(are2,2)
    are2(ji)
    if are2(1,ji)>thresh
     area2=area2+are2(1,ji);
     kk=kk+1;
    end
end
for ki=1:size(are3,2)
    if are3(1,ki)>thresh
     area3=area3+are3(1,ki);
     kkk=kkk+1;
    end
end
a1(i)=area1/k;
a2(i)=area2/kk;
a3(i)=area3/kkk;
mjl1(:)=cell2mat(struct2cell(regionprops(cbw1, 'Perimeter')));
mjl2(:)=cell2mat(struct2cell(regionprops(cbw2, 'Perimeter')));
mjl3(:)=cell2mat(struct2cell(regionprops(cbw3, 'Perimeter')));
mj1=0;
mj2=0;
mj3=0;
k=0;
kk=0;
kkk=0;
thresh2=0;
for ik=1:size(mjl1,2)
    if mjl1(1,ik)>thresh2
     mj1=mj1+mjl1(1,ik);
     k=k+1;
    end
end
for ih=1:size(mjl2,2)
    if mjl2(1,ih)>thresh2
     mj2=mj2+mjl2(1,ih);
     kk=kk+1;
    end
end
for hi=1:size(mjl3,2)
    if mjl3(1,hi)>thresh2
     mj3=mj3+mjl3(1,hi);
     kkk=kkk+1;
    end
end
mjle1(i)=mj1/k;
mjle2(i)=mj2/kk;
mjle3(i)=mj3/kkk;
mnl1(:)=cell2mat(struct2cell(regionprops(cbw1, 'Eccentricity')));
mnl2(:)=cell2mat(struct2cell(regionprops(cbw2, 'Eccentricity')));
mnl3(:)=cell2mat(struct2cell(regionprops(cbw3, 'Eccentricity')));
mn1=0;
mn2=0;
mn3=0;
k=0;
kk=0;
kkk=0;
thresh2=0;
for ti=1:size(mnl1,2)
    if mnl1(1,ti)>thresh2
     mn1=mn1+mnl1(1,ti);
     k=k+1;
    end
end
for it=1:size(mnl2,2)
    if mnl2(1,it)>thresh2
     mn2=mn2+mnl2(1,it);
     kk=kk+1;
    end
end
for ir=1:size(mnl3,2)
    if mnl3(1,ir)>thresh2
     mn3=mn3+mnl3(1,ir);
     kkk=kkk+1;
    end
end
mnle1(i)=mn1/k;
mnle2(i)=mn2/kk;
mnle3(i)=mn3/kkk;
end
a1=a1';a2=a2';a3=a3';
mjle1=mjle1';mjle2=mjle2';mjle3=mjle3';
mnle1=mnle1';mnle2=mnle2';mnle3=mnle3';