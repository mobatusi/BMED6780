function [rankedfeat]=featextract_all(yfit, norm_image)
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
are1(:)=cell2mat(struct2cell(regionprops(cbw1, 'Area')));
are2(:)=cell2mat(struct2cell(regionprops(cbw2, 'Area')));
are3(:)=cell2mat(struct2cell(regionprops(cbw3, 'Area')));
a1=mean(are1);
a2=mean(are2);
a3=mean(are3);
%%
mjl1(:)=cell2mat(struct2cell(regionprops(cbw1, 'MajorAxisLength')));
mjl2(:)=cell2mat(struct2cell(regionprops(cbw2, 'MajorAxisLength')));
mjl3(:)=cell2mat(struct2cell(regionprops(cbw3, 'MajorAxisLength')));
mjle1=mean(mjl1);
mjle2=mean(mjl2);
mjle3=mean(mjl2);
%%
mnl1(:)=cell2mat(struct2cell(regionprops(cbw1, 'MinorAxisLength')));
mnl2(:)=cell2mat(struct2cell(regionprops(cbw2, 'MinorAxisLength')));
mnl3(:)=cell2mat(struct2cell(regionprops(cbw3, 'MinorAxisLength')));
mnle1=mean(mnl1);
mnle2=mean(mnl2);
mnle3=mean(mnl3);
%%
Final1(:,1)=a1;Final1(:,2)=a2;Final1(:,3)=a3;
Final1(:,4)=mjle1;Final1(:,5)=mjle2;Final1(:,6)=mjle3;
Final1(:,7)=mnle1;Final1(:,8)=mnle2;Final1(:,9)=mnle3;
%%
clear a1 ;clear are1;clear a2;clear are2;clear a3;clear are3;clear mjl1;clear mjl2;clear mjl2;
clear mjle1;clear mjle2;clear mjle3;clear mnl1;clear mnl2;clear mnl2;
clear mnle1;clear mnle2;clear mnle3;
sol1(:)=cell2mat(struct2cell(regionprops(cbw1, 'Solidity')));
sol2(:)=cell2mat(struct2cell(regionprops(cbw2, 'Solidity')));
sol3(:)=cell2mat(struct2cell(regionprops(cbw3, 'Solidity')));
s1=mean(sol1);
s2=mean(sol2);
s3=mean(sol3);
%%
per1(:)=cell2mat(struct2cell(regionprops(cbw1, 'Perimeter')));
per2(:)=cell2mat(struct2cell(regionprops(cbw2, 'Perimeter')));
per3(:)=cell2mat(struct2cell(regionprops(cbw3, 'Perimeter')));
pe1=mean(per1);
pe2=mean(per2);
pe3=mean(per3);
%%
ecc1(:)=cell2mat(struct2cell(regionprops(cbw1, 'Eccentricity')));
ecc2(:)=cell2mat(struct2cell(regionprops(cbw2, 'Eccentricity')));
ecc3(:)=cell2mat(struct2cell(regionprops(cbw3, 'Eccentricity')));
e1=mean(ecc1);
e2=mean(ecc2);
e3=mean(ecc3);
Final1(:,10)=s1;Final1(:,11)=s2;Final1(:,12)=s3;
Final1(:,13)=pe1;Final1(:,14)=pe2;Final1(:,15)=pe3;
Final1(:,16)=e1;Final1(:,17)=e2;Final1(:,18)=e3;
%%

[a, b] = histcounts(norm_image(:,:,1), 16);
[c, d] = histcounts(norm_image(:,:,2), 16);
[e, f] = histcounts(norm_image(:,:,3), 16);
Final1(:,24:71) = [a, c, e];
gray_image = rgb2gray(norm_image);
offsets = [0 1; 0 2; 0 3; 0 4; 0 5];
C = graycomatrix(gray_image, 'Offset', offsets, 'NumLevels', 64);
stats = graycoprops(C);
Final1(:,19) = sum(stats.Contrast)/5;
Final1(:,20) = sum(stats.Energy)/5;
Final1(:,21) = entropy(gray_image);
Final1(:,22) = sum(stats.Homogeneity)/5;
Final1(:,23) = sum(stats.Correlation)/5;

rankedfeat=Final1;