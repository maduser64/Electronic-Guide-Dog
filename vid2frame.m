%function v = vid2frame(~)
warning off; clear all; close all; clc;

workingDir = 'C:\Users\b1009_000\Desktop';
mkdir(workingDir);
mkdir(workingDir,'Frames');

carVideo = VideoReader('duck_army.mp4');

ii = 1;

while hasFrame(carVideo)
   frame = readFrame(carVideo);
   filename = [sprintf('frame%01d',ii) '.jpg'];
   fullname = fullfile(workingDir,'Frames',filename);
   imwrite(frame,fullname)    % Write out to a JPEG file (frame1.jpg, frame2.jpg, etc.)
   ii = ii+1;
end

imageNames = dir(fullfile(workingDir,'images','*.jpg'));
imageNames = {imageNames.name}';

NumberOfFrames=ii;
disp('Number of Frames:'),disp(NumberOfFrames);

time=carVideo.CurrentTime;
disp('Time (s):'),disp(time);

Fps=NumberOfFrames/time;
disp('Frames per second:'),disp(Fps);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

