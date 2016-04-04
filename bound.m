clc
close all;
clear;
%load imgfildata.m;

% get image file
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
% choose image file
BW=[path,file];
% input image and save as picture
BW=imread(BW);
a=imresize(BW,[304,512]);
a=BW;
if size(BW,3)==3
  BW=rgb2gray(BW);
end
%create morphological structuring element
se=strel('rectangle',[5,5]);
a=imerode(BW,se);
 
b=imdilate(a,se);
threshold = graythresh(BW);
BW =im2bw(BW,threshold);
BW = bwareaopen(BW,100000);
figure(2)
imshow(BW);
hold on;

[B,L,N,A] = bwboundaries(~BW);
figure; imshow(a); hold on;
% Loop through object boundaries
for k = 1:N
    % Boundary k is the parent of a hole if the k-th column
    % of the adjacency matrix A contains a non-zero element
    if (nnz(A(:,k)) > 0)
        boundary = B{k};
        plot(boundary(:,2),...
            boundary(:,1),'r','LineWidth',2);
        % Loop through the children of boundary k
        for l = find(A(:,k))'
            boundary = B{l};
            plot(boundary(:,2),...
                boundary(:,1),'g','LineWidth',2);
        end
    end
end
