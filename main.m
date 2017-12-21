clear all
clc
disp('START main ---- ---- ---- ----')

% READ IMAGE DATA
file = dir('Sequenz/*.jpg');
NF = length(file);
images = cell(NF,1);
for k = 1 : NF
  inputPic = imread(fullfile('Sequenz', file(k).name));
  inputPic = mat2gray(inputPic);
  resizedPic = imresize(inputPic, 0.5);
  images{k} = resizedPic;
 
end

I=images{1};
I=rgb2gray(I);
level = graythresh(I); %get the perfect threshold from this Image ;)
BW = im2bw(I,level);


[labels,num1] = bwlabel(BW); %Find connected areas and label them with numbers
RGB = label2rgb(labels,'gray'); %gray defines the colormap. it is int (1:256)
% figure('name','RGB image')    
% imshow(RGB)

vec = 1:256;
[tf,loc] = ismember(vec,RGB);

num2=loc(loc~=0);           %get a vector filled with object sizes
number_of_objects = length(num2)
mean_object_size = mean(num2)



% se=strel('disk',10);  
% BW=imerode(~BW,se);
% figure('name','blackwhite2');
% imshow(~BW)

%L = watershed(images{1})
%STATS = regionprops(L, 'Area')
%[A,n] = findPartikel(inputPic)


% figure('name','RESULT');
% subplot(2,1,1);
% imagesc(inputPic);
% title('input');
% subplot(2,1,2); 
% imagesc(resizedPic);
% title('watershed');
disp('SUCCESS')
