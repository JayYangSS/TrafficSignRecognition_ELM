%load the GTSRB Imgs hog features for ELM
function train_data=GTSRBImgDataRead(BasePath)
%'E:\迅雷下载\GTSRB_DATASET\GTSRB_Final_Training_HOG\GTSRB\Final_Training\HOG\HOG_01'
sBasePath =BasePath; 
train_data=[];
step=10;% the step of sample the images


for nNumFolder = 0:42
    sFolder = num2str(nNumFolder, '%05d');
    
    sPath = [sBasePath, '\', sFolder, '\'];
    
    

    if isdir(sPath)
        
        numFiles=size(dir(sPath),1)-2;
        bigerKindNum=numFiles/30;
        for biggerClass=0:bigerKindNum-1
            prefix=num2str(biggerClass,'%05d');
            
            for index=0:step:29
                fileId = num2str(index, '%05d');
                fileName=[sPath,prefix,'_',fileId,'.ppm'];
                img=imread(fileName);
                HOGFeature=hogcalculator(img);
                HOG_with_classId=[nNumFolder,HOGFeature];
                train_data=[train_data;HOG_with_classId];
            end
            
        end
        
    end
        
end
end