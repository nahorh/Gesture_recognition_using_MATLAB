
clc
% clear
% close all
load trainedNet.mat
% img=imread('1.png');
% img=rgb2gray(img);
imgData=imageDatastore("A:\mitwpu\ty\tri 1\Digital Signal Processing\Grp Project\UsingMATLAB\randomDatabase\",'IncludeSubfolders',false,'LabelSource','none');
img=imgData.Files;
for i=1:length(img)
%     read the image one by one
   path=img(i);
   path=string(path(1));
   img1=imread(path);
   img1=imresize(img1,[227 227]);
   figure(1);
   imshow(img1);
 
%    recognize the gesture
[label,score]=classify(trainedNet,img1);
img2=insertText(img1,[95.5 108.5],char(label));
imshow((img2));
disp(label);
disp(score);
w=waitforbuttonpress;
%    pause(1);
end
% img=imresize(img,[227 227]);
% [label,score]=classify(trainedNet,img);
% disp(label);
% disp(score);