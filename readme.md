# Using ELM to recognize traffic signs

This repository is trying to recognize the traffic signs by neural networks, the weight matrix is trained by ELM(Extreme Learning Machines).


ELM method can be referenced by: http://www.ntu.edu.sg/home/egbhuang/

The dataset that I use is [GTSRB](http://benchmark.ini.rub.de/?section=gtsrb&subsection=news). This dataset contains 43 kinds of traffic signs. I haven't used all the training samples because of the memory limitation in my computer. If you want to use all training samples of the GTSRB,just change the step from 2 to 1 in the `GTSRBDataRead.m`,line 21.


I used the half of the training samples to train the neural network. The tsting accuracy is 91.94% for the 43 classes of traffic signs.

running this code:
```matlab
%training
[trainTime,trainAccuracy]=elm_train('',1,9000,'sig',0);

%tesing
[TestingTime, TestingAccuracy] = elm_predict('');
```