
clc
clear
close all
net=alexnet;
layers=net.Layers;

layers(23)=fullyConnectedLayer(6,'WeightLearnRateFactor',2,'BiasLearnRateFactor',2);
layers(25)=classificationLayer;
ImageData=imageDatastore('database','IncludeSubfolders',true, 'LabelSource','foldernames');
options=trainingOptions('sgdm','MiniBatchSize',20,'MaxEpochs',5,'InitialLearnRate',0.0001,'Shuffle','every-epoch','Verbose',false,'Plots','training-progress');
trainedNet=trainNetwork(ImageData,layers,options);
save trainedNet;