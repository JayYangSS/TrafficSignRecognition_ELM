clear all;
detector = vision.CascadeObjectDetector('trainedDetetorXML\trainedDetector7.xml');

load elm_model_ChinaSign.mat;%load ELM trained model
%figure;
for dirIndex=107:119 % traversal the directory
dirPath=['D:\JY\TrafficSignRecognition_ELM\TrafficSignVideoTest\detectorTrainingFiles\常熟比赛数据集\训练数据集-2016.07.25.release\TSD-Signal_part03\TSD-Signal\TSD-Signal-'...,
    num2str(dirIndex,'%05d')];
imgNums=length(dir([dirPath,'\*.png']));

frameId=cell(imgNums,1);
targetNum=cell(imgNums,1);
targetResult=cell(imgNums,1);


for imgIndex=0:imgNums-1
    imgName=[dirPath,'\TSD-Signal-',num2str(dirIndex,'%05d'),'-',num2str(imgIndex,'%05d'),'.png'];
    img=imread(imgName);
    
    %detect traffic signs
    bboxes = step(detector,img);
    
    %recognize TS
    numBox=size(bboxes,1);%number of detected box
    numTarget=numBox;
    if numBox>0
        label_str=cell(numBox,1);
        container={};
        boxCount=1;
        for boxIndex=1:numBox
            bbox=bboxes(boxIndex,:);
            detectedRegions=imcrop(img,bbox);
            imgHOG=hogcalculator(detectedRegions);
            tempH_test=InputWeight*imgHOG';          
            tempH_test=tempH_test + BiasofHiddenNeurons;
            switch lower(ActivationFunction)
            case {'sig','sigmoid'}%%%%%%%% Sigmoid 
                H_test = 1 ./ (1 + exp(-tempH_test));
            case {'sin','sine'}%%%%%%%% Sine
                H_test = sin(tempH_test);        
            case {'hardlim'}%%%%%%%% Hard Limit
                H_test = hardlim(tempH_test);          
            end
            TY=(H_test' * OutputWeight)';
            [x, label_index_actual]=max(TY);
            output=label(label_index_actual);%get the traffic sign classId
            label_str{boxIndex}=char(mapId2TypeString(output+1));
            if output==0
                numTarget=numTarget-1;
                continue;
            end
            container{boxCount,1}=bbox;
            container{boxCount,2}=char(mapId2TypeString(output+1));
            boxCount=boxCount+1;
        end 
       
        targetResult{imgIndex+1}=container;
        img = insertObjectAnnotation(img,'rectangle',bboxes,label_str,'TextBoxOpacity',0.9,'FontSize',18);
    end
    frameId{imgIndex+1}=imgIndex;
    targetNum{imgIndex+1}=numTarget;
    imshow(img);
end

recogResult=struct('frameId',frameId,'targetNum',targetNum,'targetResult',targetResult);
xmlName=['TSD-Signal-',num2str(dirIndex,'%05d'),'-Result.xml'];

%output the result as the xml format for openCV
getXMLResult(recogResult,xmlName,'w');

end


%rmpath(imDir);
