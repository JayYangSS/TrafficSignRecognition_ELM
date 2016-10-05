## trainedModel1.xml:
该文件的训练参数为：stage=15, falseAlarmRate=0.2(实际由于负样本数量不够，stage训练到10),正样本2000张，负样本全部为LISA数据集中的dayTest图片

## trainedDetector1.xml:
该文件的训练参数为：stage=15, falseAlarmRate=0.2(实际由于负样本数量不够，stage训练到10),正样本2000张，负样本为LISA数据集中的dayTest图片+车道线数据集+几张标志牌背景图片

## trainedDetector2.xml:
该文件的训练参数为：stage=15, falseAlarmRate=0.4(stage训练到15),正样本2000张，负样本为LISA数据集中的dayTest图片+车道线数据集+几张标志牌背景图片

## trainedDetectorLBP.xml:
使用的stage为15，实际训练到14（负样本数量不够），falseAlarmRate设置为0.3

## trainedDetectorHaar.xml
使用Haar特征进行训练，训练时间较长（其他的文件都是使用HOG特征训练的），误检测较多，漏检较少。