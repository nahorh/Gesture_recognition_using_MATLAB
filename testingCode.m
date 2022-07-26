clc
close all
clear
% cam=ipcam('http://192.168.1.192/video','123','123');
cam=webcam(3);%choose webcam 
cam.AvailableResolutions;

w1='640';%define width for the camera
h1='480';%define height for the camera
cam.Resolution=strcat(w1,'x',h1);%set the resolution of camera
cam.Brightness=30;%adjust the brightness of the camera
w='227';
h='227';
load trainedNet.mat;
x=206.5;%starting position of the processing area
y=0;%ending position of the processing  area
height=227;
width=227;
focusingArea=[x y width height];
while true
    img=cam.snapshot;
%     RGB2 = imadjust(RGB,[.2 .3 0; .6 .7 1],[]);
    img=fliplr(img);
    FinalImg = insertObjectAnnotation(img,'rectangle',focusingArea,'Processing Area','Color','red','TextBoxOpacity',1,'LineWidth',9,'TextColor','black');%define the processing area
    FinalImg=insertShape(FinalImg,'FilledRectangle',[0 0 x str2double(h1)],'Color','white','Opacity',0.9);%insert the left side filled rectangle
    FinalImg=insertShape(FinalImg,'FilledRectangle',[(x+width) 0 str2double(w1) str2double(h1)],'Color','white','Opacity',0.9);%inser the right side filled rectangle
    FinalImg=insertShape(FinalImg,'FilledRectangle',[x str2double(h1)/2+5 width str2double(h1)/2],'Color','white','Opacity',0.9);%inser the lower side center rectangle
    ImgToBeClassified=imcrop(img,focusingArea);%crop the captured image
    ImgToBeClassified=imresize(ImgToBeClassified,[227 227]);%resize the image
    [label,score]=classify(trainedNet,ImgToBeClassified);%get the classification of the image along with prediction score
    FinalImg= insertText(FinalImg,[260 108.5],char(label),'TextColor','black');%insert the appropriate txt in to classified image
%     disp(label);
%     disp(score);
    imshow(FinalImg);
    title(char(label));
    drawnow;%update the title of the figure after every iteration
end