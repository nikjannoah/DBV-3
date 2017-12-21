clear all
clc
disp('START main ---- ---- ---- ----')


inputPic = imread('./Sequenz/04_0000.jpg');
inputPic = mat2gray(inputPic);
resizedPic = imresize(inputPic, 0.5);
I=rgb2gray(resizedPic);
level = graythresh(I); %get the perfect threshold from this Image ;)
BW = im2bw(I,level);


[labels,num1] = bwlabel(BW); %Find connected areas and label them with numbers
RGB = label2rgb(labels,'gray'); %gray defines the colormap. it is int (1:256)


vec = 1:256;
[tf,loc] = ismember(vec,RGB);


num2=loc(loc~=0);           %get a vector filled with object sizes
number_of_objects = length(num2);
mean_object_size = mean(num2/10000);


disp('SUCCESS');