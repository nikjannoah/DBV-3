function [A,n] = findPartikel(I)
% n is the number of elements in the picture
% A is a vector with the num of pixels of every element which represents the surface
    I=rgb2gray(I);    

    I2 = imtophat(I, strel('disk', 100));
    
    level = graythresh(I); %get the perfect threshold from this Image ;)
    BW = im2bw(I,level); %black white image
    %figure('name','blackwhite');
    %imshow(BW);
 
    %figure;
    D = -bwdist(BW); %negate the Pic (so the background is white)
    %bwdist computees the distance transform. The distance transform of a
    %binary image is the distance form every pixel to the nearest
    %nonzero-valued pixel
 
    imshow(D,[min(min(D)) max(max(D))])
 
    D(BW) = -Inf;
    %modify the image so that the background pixels and the extended maxima
    %pixels are forced to be the only local minima in the image
 
    I = imhmax(I,12);
    figure('name','debug figure 1');
    imshow(I);
 
    %D = -single(I);
    figure('name','watershed input');
    imshow(D);
    
    L = watershed(D);
  
    figure('name','watershed output');
    imshow(L);
    
    BW(L==0)=0;
     
    %%
    %remove noise
    se=strel('disk',10);  
    BW=imdilate(imerode(BW,se),se);
    figure;
    subplot(2,1,1)
    title('nachher');
    imshow(BW);
    subplot(2,1,2);
    imshow(I);
     
    %% Calculate the surface area
    labels = bwlabel(BW); %Find connected areas and label them with numbers
    %imshow(labels)
    A(1:max(labels(:)),1)=0;
    for i = 1:max(labels(:));
        A(i) = size(find(labels==i),1); %count all pixels of every Labeld surface 
    end
    %The num of pixels represents the surface! ;)
    n=length(A);
    title(strcat('Gefundene Teilchen:',num2str(n)));
end
