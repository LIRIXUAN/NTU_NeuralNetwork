clear
clc

load('data_test.mat')
load('data_train.mat')
load('label_train.mat')

nNeuron = 20; nSomRow = 4; nSomCol = 5;

[nSample, nDimen] = size(data_train); % get number of sample & dimension 
dataNorm = zeros(size(data_train)); % create zero matrix that has the same size of date_train

for j = 1:nDimen
    dataNorm(:,j) = (data_train(:,j)-min(data_train(:,j)))/range(data_train(:,j)); % focus on each colum
end

for j = 1:size(data_test,2) % size of colum
    dataTestNorm(:,j)=(data_test(:,j)-min(data_test(:,j)))/range(data_test(:,j));
end

[CenterVec, clusterId] = SOM(nNeuron, nSomRow, nSomCol, dataNorm, 1000);

%%%%%%%%%% part two %%%%%%%%%%%%
gMethod = 'Gaussian'; gWidth = 1;

trainRange = 1:330; testRange = 1:330;

RBFW = RBFTrainWeight(nNeuron, CenterVec, dataNorm(trainRange,:), label_train(trainRange,:), gMethod, gWidth);

[output,RBFValu] = RBFTest(CenterVec, RBFW, dataNorm(testRange,:), gWidth);

results = [0,-1];
for threshold = min(RBFValu):0.001:max(RBFValu)
    
    labels = Threshold(RBFValu, threshold);
    
    correct = 0;
    for i = 1:size(labels, 1)
        if labels(i) == label_train(i)
            
            correct = correct+1;
        end
    end
    
    results = [results; [threshold, double(correct)/size(labels,1)]];
end

[maxAccuracy, id] = max(results(:,2));

threshold = results(id,1);
labels = Threshold(RBFValu, threshold);

correct = 0;
for i = 1:size(labels, 1)
    if labels(i) == label_train(i)
        
        correct = correct+1;
    end
end
accuracy = double(correct)/size(labels,1);

[output, testValues] = RBFTest(CenterVec, RBFW, dataTestNorm, gWidth);
testLabels = Threshold(testValues, threshold);