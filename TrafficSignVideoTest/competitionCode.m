clear all;
detector = vision.CascadeObjectDetector('trainedDetetorXML\trainedDetector7.xml');

load elm_model_ChinaSign.mat;%load ELM trained model
%figure;

testDataPath='C:\Users\Yang\Desktop\testPath\';
testResultSavePath='TSD-Signal-Result-CyberTiggo\';
testDataDir=dir(testDataPath);
directoryNum=length(testDataDir);

for index=3:directoryNum
    % get the test image path
    subDirName=testDataDir(index).name;
    dirPath=[testDataPath,subDirName];
    imgNums=length(dir([dirPath,'\*.png']));

    frameId=cell(imgNums,1);
    targetNum=cell(imgNums,1);
    targetResult=cell(imgNums,1);


    for imgIndex=0:imgNums-1
        imgName=[dirPath,'\',subDirName,'-',num2str(imgIndex,'%05d'),'.png'];
        img=imread(imgName);

        %detect traffic signs
        bboxes = step(detector,img);

        %recognize TS
        numBox=size(bboxes,1);%number of detected box
        numTarget=numBox;
        if numBox>0
            label_str=cell(numBox,1);
            container={};%set the target details
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
                %output=label(label_index_actual);%get the traffic sign classId
                label_str{boxIndex}=char(mapId2TypeString3(label_index_actual));
    %             if output==0
    %                 numTarget=numTarget-1;
    %                 continue;
    %             end
                container{boxCount,1}=bbox;
                container{boxCount,2}=char(mapId2TypeString3(label_index_actual));
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
    xmlName=[testResultSavePath,subDirName,'-Result.xml'];

    %output the result as the xml format for openCV
    getXMLResult(recogResult,xmlName,'w');

end
display('Data process finished!');
%rmpath(imDir);
