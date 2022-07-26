clear,close all;
clc;
w='640';
h='480';
cam=webcam(1);
cam=fliplr(cam);
cam.Resolution=strcat(w,'x',h);
% preview(cam);
% pause(300);
x=0;
y=0;
height=str2double(h)/2;
width=str2double(w)/3;
bboxes=[x y width height];
temp=0;
temp1=0;
while temp1<100
sample=cam.snapshot;
sample=fliplr(sample);
FixedSample=insertObjectAnnotation(sample,'rectangle',bboxes,'Keep your hand within yellow border','Color','red','LineWidth',2);
imshow(FixedSample);
drawnow;
temp1=temp1+1;
end
pause(5);
while temp<10
    img=cam.snapshot;
    img=fliplr(img);
    Img=insertObjectAnnotation(img,'rectangle',bboxes,'Keep your hand within yellow border','Color','cyan','LineWidth',4);
    imshow(Img);
    pause(2);
    if temp>225
    fprintf('Warning%d\n',temp);
    end
    filename=strcat(num2str(temp),'.png');
    croppedImg=imcrop(img,bboxes);
    resizedImg=imresize(croppedImg,[227 227]);
    imwrite(resizedImg,filename);
    temp=temp+1;
    drawnow;
end
clear
pause(2);
close all