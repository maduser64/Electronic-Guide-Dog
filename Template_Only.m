%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TEMPLATE MATCHING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all;
clear;
load imgfildata.m;

% get image file
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
% choose image file
s=[path,file];
% input image and save as picture
picture=imread(s);
[~,cc]=size(picture);
% resize the image to speed up processing
picture=imresize(picture,[255 512]);

if size(picture,3)==3
  picture=rgb2gray(picture);
end
% create morphological structuring element
 %se=strel('rectangle',[5,5]);
 %a=imerode(picture,se);
 %figure(1)
 %imshow(a);
 
%b=imdilate(picture,se);
threshold = graythresh(picture);
picture =~im2bw(picture,threshold);
picture = bwareaopen(picture,30);
figure(2)
imshow(picture)
if cc>2000
    picture1=bwareaopen(picture,5500);
else
picture1=bwareaopen(picture,9000);
end
%figure(2)
%imshow(picture1)
image2=picture-picture1;
figure(3)
imshow(image2);

% match with template
% read Target Image
% get image file
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
% choose image file
s=[path,file];
% input image and save as picture im2
image1=imread(s);
image1=im2bw(image1);
image1=imresize(image1,[28 180]);
image1=~image1;
%image2=~image2;

% apply templete matching using power of the image
%result1=tmp(im2, picture2);
if size(image1,3)==3
    image1=rgb2gray(image1);
end
if size(image2,3)==3
    image2=rgb2gray(image2);
end

% check which one is target and which one is template using their size

if size(image1)>size(image2)
    Target=image1;
    Template=image2;
else
    Target=image2;
    Template=image1;
end

% find both images sizes
[r1,c1]=size(Target);
[r2,c2]=size(Template);
% mean of the template
image22=Template-mean(mean(Template));

%corrolate both images to find template matched
M=[];
for i=1:(r1-r2+1)
    for j=1:(c1-c2+1)
        Nimage=Target(i:i+r2-1,j:j+c2-1);
        Nimage=Nimage-mean(mean(Nimage));  % mean of image part under mask
        corr=sum(sum(Nimage.*image22));
        warning off
        M(i,j)=corr/sqrt(sum(sum(Nimage.^2)));
    end 
end

% plot box on the target image
%result=plotbox(Target,Template,M);

[r1,c1]=size(Target);
[r2,c2]=size(Template);

[r,c]=max(M);
[r3,c3]=max(max(M));

i=c(c3);
j=c3;
result=Target;
for x=i:i+r2-1
   for y=j
       result(x,y)=255;
   end
end
for x=i:i+r2-1
   for y=j+c2-1
       result(x,y)=255;
   end
end
for x=i
   for y=j:j+c2-1
       result(x,y)=255;
   end
end
for x=i+r2-1
   for y=j:j+c2-1
       result(x,y)=255;
   end
end

figure(7)
subplot(2,2,1),imshow(image2);title('Template');
subplot(2,2,2),imshow(image1);title('Target');
subplot(2,2,3),imshow(result);title('Matching Result using tmp');
subplot(2,2,4),imshow(~Nimage);title('Plotbox'),grid ON;

[r4,c4]=size(Nimage);
area1=r4*c4;
area2=2.992*10.492; % size of number plate at 0m
perc=(area2/area1)*100;

%%%%%%%%%%%%%%%%%%%%%%%%
%xcorr
%%%%%%%%%%%%%%%%%%%%%%%%