%trainMode --1  just train detector
%          --2  just train classifier
%          --0  train detector and classifier
trainMode=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% train the traffic sign detector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (trainMode==1||trainMode==0)
startIndex=0;  %the start index in the sub directory of the training files
endIndex=119;  %the end index in the sub directory of the training files
imgWidth=1280;
imgHeight=1024;
trafficSign_data_info=conanecateStruct(startIndex,endIndex,imgWidth,imgHeight);%load the struct of positive samples info for traffic sign detector
negativeFolder='detectorTrainingFiles\ChanshuNegativeSamples';  %path of negative samples for traffic sign detector
trafficSignDetectorName='trainedDetector7.xml';

%train the traffic sign detector and save the training result into xml files specified by 'trafficSignDetectorName'.
trainCascadeObjectDetector(trafficSignDetectorName,trafficSign_data_info,negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',15);
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% train the traffic sign classifier by ELM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (trainMode==2||trainMode==0)
TrainingData_folder='ClassifierTrainingSamples\GTSRB_Final_Training_Images\GTSRB\Final_Training\Images'; %Folder path of training data set
Elm_Type=1;  % 0 for regression; 1 for (both binary and multi-classes) classification
NumberofHiddenNeurons=9000;
ActivationFunction='sig';
isLoad=0;  %isLoad=1,load data from mat,isLoad=0,get data from source images
% train elm classifier for traffic signs ,and save elm model as elm_model.mat
[TrainingTime,TrainingAccuracy] = elm_train(TrainingData_folder,1, NumberofHiddenNeurons,ActivationFunction,isLoad);
end