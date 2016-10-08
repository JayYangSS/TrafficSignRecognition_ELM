# instruction

if you want to retrain the detector and classifier, please run the `trainingScript.m`

if you don't want train and just want to use the existing trained files(Have been trained with the `trainingScript.m` and get the files such as 'elm_model.mat','trainedDetector6.xml'), just run `videoRead.m`

`elm_model_step1.mat` is trained with all the samples used in GTSRB dataset(while `elm_model.mat` is trained with just 10% of the dataset).  The training accuracy is 99.93%

`elm_model_ChinaSign.mat` is the elm model trained with the Tsinghua-Tencent 100K dataset, the number of training samples is 11748, the feature is HOG, training samples' size is larger than 1600.
