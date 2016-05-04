function testHOGdata=readTestData()

    labelFilePath='E:\Ñ¸À×ÏÂÔØ\GTSRB_DATASET\GTSRB_Final_Test_Images\GTSRB\GTSRB_Final_Test_GT\GT-final_test.csv';
    HOG_testBasePath='E:\Ñ¸À×ÏÂÔØ\GTSRB_DATASET\GTSRB_Final_Test_HOG\GTSRB\Final_Test\HOG\HOG_01\';
    
    fID = fopen(labelFilePath, 'r');
    
    fgetl(fID); % discard line with column headers
    
    f = textscan(fID, '%s %*d %*d %d %d %d %d %d', 'Delimiter', ';');
    %get the label of test image
    rClasses = f{6};
    fclose(fID);
    
    HOGFeatureMat=zeros(1568,12630);
    for num=0:12629
        fileName=num2str(num, '%05d');
        testHOGPath=[HOG_testBasePath,fileName,'.txt'];
        
        %get the test HOG data
        tmp=load(testHOGPath);
        HOGFeatureMat(:,num+1)=tmp;
    end
    testHOGdata=[double(rClasses),HOGFeatureMat'];
end