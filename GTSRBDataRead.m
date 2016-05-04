%load the GTSRB data for ELM
function train_data=GTSRBDataRead(BasePath)
%'E:\Ñ¸À×ÏÂÔØ\GTSRB_DATASET\GTSRB_Final_Training_HOG\GTSRB\Final_Training\HOG\HOG_01'
sBasePath =BasePath; 
train_data=[];

for nNumFolder = 0:42
    sFolder = num2str(nNumFolder, '%05d');
    
    sPath = [sBasePath, '\', sFolder, '\'];
    
    

    if isdir(sPath)
        
        numFiles=size(dir(sPath),1)-2;
        bigerKindNum=numFiles/30;
        for biggerClass=0:bigerKindNum-1
            prefix=num2str(biggerClass,'%05d');
            
            for numFiles=0:2:29
                fileId = num2str(numFiles, '%05d');
                fileName=[sPath,prefix,'_',fileId,'.txt'];
                HOGFeature=load(fileName);
                HOG_with_classId=[nNumFolder;HOGFeature];
                train_data=[train_data,HOG_with_classId];
            end
            
        end
        
    end
        
end

train_data=train_data';
end