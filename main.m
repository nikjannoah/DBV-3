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

L = watershed(images{1})
STATS = regionprops(L, 'Area')



disp('SUCCESS')
figure('name','RESULT');
subplot(2,1,1);
imagesc(inputPic);
title('input');
subplot(2,1,2); 
imagesc(resizedPic);
title('watershed');
