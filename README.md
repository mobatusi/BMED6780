# BMED6780
Medical Image Processing

The goal of this project is to learn and implement the complete translational biomedical image processing pipeline for clinical decision support. Specifically, to apply image processing and data mining techniques to cancer histopathological images, and to develop an objective and reproducible decision support for diagnosis and prognosis of cancers.

Authors
- Mosadoluwa Obatusin
- Ashkan Ojaghi
- Nishanth Raopalimarraghupathi

## This course term project was divided into two modules: 
1.1) Automatic segmentation of nuclear structures 
1.2) Image feature extraction and exploration 
2.0) Image classification

Although this project is ongoing,the preliminary report can be found here:
https://www.overleaf.com/8714929vxbnbchsxykc

## Dataset 1:
100 digital microscopic images of hematoxylin and eosin (H&E) stained tissue sections of kidney clear cell carcinoma consisting of 100 tumor, 100 necrosis, and 100 stroma sections will be provided.H&E staining enhances three colors:  blue-purple, white, and pink. These colors correspond to specific cellular structures. 
<p align="center">
  <img src="https://cloud.githubusercontent.com/assets/22042303/25307288/53392f36-276c-11e7-86b6-af3809c89f0b.png" width="150"/>
  <img src="https://cloud.githubusercontent.com/assets/22042303/25307290/5889a826-276c-11e7-9c79-8a938e9bf87b.png" width="150"/>  
    <img src="https://cloud.githubusercontent.com/assets/22042303/25307291/5df8f6f4-276c-11e7-903f-b620a82d5fdd.png" width="150"/>  
</p>
<p align="center">
<b>Necrosis |</b>
<b>Stroma   |</b>
<b>Tumor     </b>
</p>
## Dataset 2:
The second dataset consists of 512×512-pixel rectangular portions of 100 whole-slide images (WSIs) of kidney clear cell carcinoma patients. Each patient is represented by 16 adjacent portions labeled as [patient name]_Tile_[row number]_[column number].png. Each patient is associated with the grade of cancer and the number of survival days. 


## Dataset 3:
The third dataset comprises of 512×512-pixel rectangular portions of 59 whole-slide images (WSIs) of pancreatic cancer patients. Each patient is represented by 16 randomly selected portions labeled as [patient name]_Tile.png. Each patient is associated with the grade of cancer and the number of survival days. However, in this module, there is no need to consider the clinical labels of the images when developing segmentation meth\item 512×512-pixel rectangular portions of 59 whole-slide images (WSIs) of pancreatic cancer patients.ods.

