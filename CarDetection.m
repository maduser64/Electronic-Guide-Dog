clc; clear all; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Autor Mark Pyott
%%Electronic Guide Dog Project
%%2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%Load first frame from camera%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = imread('caruk.jpg');  %%Read Image From File
outputSize=[255,512];
I=imresize(I,outputSize);      %%Resize Image To Speed Up Processing
BW = im2bw(I);          %%Convert Image To Binary
figure(1);
imshow(~BW);             %%Display Binary Image

dim = size(BW);
col = 240;
row = 148;
disp(dim);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boundary = bwtraceboundary(BW,[row, col],'N');                  %
figure(2);                                                      %
imshow(I);                                                      %
hold on;                                                        %
plot(boundary(:,2),boundary(:,1),'g','LineWidth',2); 
%hold on; plot(col, row,'gx','LineWidth',2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save boundary2
BW_filled = imfill(BW,'holes');
boundaries = bwboundaries(BW_filled,8,'holes');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Now find Number plate using anpr




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%Load second frame from camera%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I2 = imread('caruk.jpg');  %%Read Image From File
outputSize=[255,400];
I2=imresize(I2,outputSize);      %%Resize Image To Speed Up Processing
BW2 = im2bw(I2);          %%Convert Image To Binary
figure(4);
imshow(BW2);             %%Display Binary Image

dim = size(BW2)
col = round(dim(2)/2)-90;
row = min(find(BW2(:,col)))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boundary2 = bwtraceboundary(BW,[row, col],'N');                  %
figure(5);                                                      %
imshow(I2);                                                      %
hold on;                                                        %
plot(boundary2(:,2),boundary2(:,1),'r','LineWidth',0.1);          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW_filled = imfill(BW,'holes');
boundaries2 = bwboundaries(BW_filled,8,'holes');
save boundary2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Comparing the two frames to classify between a safe or an unsafe road
%%crossing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%????can the length of the boundary be found????
div=mrdivide(boundary,boundary2);%%divide the two boundaries then
safe=div*100;                       %%multiple by 100 to get percentage

%%calculations to be done to classify between a safe or and unsafe road
%%crossing
if{
        safe>=10;
        disp('safe road crossing');
        }

elseif{
            safe<10;
            disp('unsafe road crossing');
            }

else{
            disp('system fault');
            }
end
    
