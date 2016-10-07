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

## trainedDetector7.xml:
训练参数如下：

```matlab
trainCascadeObjectDetector(trafficSignDetectorName,trafficSign_data_info,negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',15);
```
本文件是增加了Tsinghua-Tencent数据集中6000多张other样本后训练的detector文件，负样本总数量达到12525个，为了解决训练过程中的负样本数量不足的问题。15个stage训练完毕，使用的特征为HOG。
使用该文件的误检少很多，但是漏检也比较多。但是就检测结果而言，效果比之前的结果好了很多。