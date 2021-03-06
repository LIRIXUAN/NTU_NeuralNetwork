close all
clear
clc

load('data_test.mat')
load('data_train.mat')
load('label_train.mat')

numNrn=20;

nSomRows=4;
nSomCols=5;

% [cVec, clusterId]=SOM(numNrn, nSomRows, nSomCols, data_train, 10000);

[numSmp, numDim]=size(data_train);
dataNorm=zeros(numSmp,numDim);

for j=1:numDim
    dataNorm(:,j)=(data_train(:,j)-min(data_train(:,j)))/range(data_train(:,j));
end

for j=1:size(dataNorm(:,j) = (data_train(:,j)-min(data_train(:,j)))/range(data_train(:,j)));
end

somNet = selforgmap([4 5]);
somNet = train(somNet, transpose(dataNorm));
%view(somNet)
classes=vec2ind(somNet(transpose(dataNorm)));

cVec=zeros(20,33);
for i=1:size(dataNorm, 1)
    cVec(classes(i),:)=double(cVec(classes(i),:))+double(dataNorm(i,:));
end
cVec=cVec/double(size(dataNorm, 1));

gMethod='Gaussian';
gWidth=1;

trainRange=1:330;
testRange=1:330;

rbfW=RBFTrainWeight(numNrn, nSomRows, nSomCols, cVec, dataNorm(trainRange,:), label_train(trainRange,:), gMethod, gWidth);

[output,rbfValues]=RBFTest(cVec, rbfW, dataNorm(testRange,:), gMethod, gWidth);

results=[0,-1];
for threshold=min(rbfValues):0.01:max(rbfValues)
    
    labels=Threshold(rbfValues, threshold);
    
    correct=0;
    correctLabels=label_train(testRange,:);
    
    for i=1:size(labels, 2)
        if labels(i)==correctLabels(i)
            
            correct=correct+1;
        end
    end
    
    results=[results; [threshold, double(correct)/size(labels,2)]];
end

[maxAccuracy, id]=max(results(:,2));

threshold=results(id,1);
labels=Threshold(rbfValues, threshold);

correct=0;
correctLabels=label_train(testRange,:);
for i=1:size(labels, 2)
    if labels(i)==correctLabels(i)
        
        correct=correct+1;
    end
end
double(correct)/size(labels,2)

testValues=RBFTest(cVec, rbfW, data_test, gMethod, gWidth);
testLabels=Threshold(testValues, threshold);