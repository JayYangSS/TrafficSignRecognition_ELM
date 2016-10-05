clear all;
%filename='E:\BaiduYunDownload\模糊图像处理竞赛\训练数据集\交通标志图像识别挑战赛\交通标识识别视频训练集partA\082\082.avi';
%filename='E:\BaiduYunDownload\模糊图像处理竞赛\初赛数据集及相关文档\交通标识图像识别挑战赛\发布1010\072\072.avi';
%filename=='D:\JY\JY_TrainingSamples\BroadView\tmp';
detector = vision.CascadeObjectDetector('trainedDetetorXML\trainedDetectorHaar.xml');

%imDir = fullfile(matlabroot,'toolbox','vision','visiondata','stopSignImages');
%addpath(imDir);

load elm_model_step1.mat;%load ELM trained model
figure;
for videoIndex=1:150
filename=['E:\BaiduYunDownload\模糊图像处理竞赛\初赛数据集及相关文档\交通标识图像识别挑战赛\发布1010\',num2str(videoIndex,'%03d'),'\',num2str(videoIndex,'%03d'),'.avi'];
v = VideoReader(filename);

%read images from video
while hasFrame(v)
    video = readFrame(v);
    img=imresize(video,0.6);
    
    %detect traffic signs
    bboxes = step(detector,img);
    
    %recognize TS
    numBox=size(bboxes,1);%number of detected box
    if numBox>0
        label_str=cell(numBox,1);
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
            %detectedImg = insertObjectAnnotation(img,'rectangle',bbox,output);
        end 
        detectedImg = insertObjectAnnotation(img,'rectangle',bboxes,label_str,'TextBoxOpacity',0.9,'FontSize',18);
        imshow(detectedImg);
    else
        imshow(img);
    end
    
end
whos video
end


rmpath(imDir);
