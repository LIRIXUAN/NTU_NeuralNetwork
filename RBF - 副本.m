close all
clear
clc

load('data_test.mat')
load('data_train.mat')
load('label_train.mat')

nNeuron = 20;

nSomRow = 4;
nSomCol = 5;

[nSample, nDimen] = size(data_train); % get number of sample & dimension 
dataNorm = zeros(size(data_train)); % create zero matrix that has the same size of date_train

for j = 1:nDimen
    dataNorm(:,j) = (data_train(:,j)-min(data_train(:,j)))/range(data_train(:,j));
end

for j=1:size(data_test,2)
    dataTestNorm(:,j)=(data_test(:,j)-min(data_test(:,j)))/range(data_test(:,j));
end

[cVec, clusterId]=SOM(nNeuron, nSomRow, nSomCol, dataNorm, 1000);


gMethod='Gaussian';
gWidth=1;

trainRange=1:330;
testRange=1:330;

rbfW=RBFTrainWeight(nNeuron, nSomRow, nSomCol, cVec, dataNorm(trainRange,:), label_train(trainRange,:), gMethod, gWidth);

[output,rbfValues]=RBFTest(cVec, rbfW, dataNorm(testRange,:), gMethod, gWidth);

results=[0,-1];
for threshold=min(rbfValues):0.001:max(rbfValues)
    
    labels=Threshold(rbfValues, threshold);
    
    correct=0;
    correctLabels=label_train(testRange,:);
    
    for i=1:size(labels, 1)
        if labels(i)==correctLabels(i)
            
            correct=correct+1;
        end
    end
    
    results=[results; [threshold, double(correct)/size(labels,1)]];
end

[maxAccuracy, id]=max(results(:,2));

threshold=results(id,1);
labels=Threshold(rbfValues, threshold);

correct=0;
correctLabels=label_train(testRange,:);
for i=1:size(labels, 1)
    if labels(i)==correctLabels(i)
        
        correct=correct+1;
    end
end
accuracy=double(correct)/size(labels,1);

[output, testValues]=RBFTest(cVec, rbfW, dataTestNorm, gMethod, gWidth);
testLabels=Threshold(testValues, threshold);