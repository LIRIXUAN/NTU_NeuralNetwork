function [CenterVec, clusterId] = SOM(nNeuron, nSomRow, nSomCol, dataNorm, iteraMax) 

[nSample, nDimen] = size(dataNorm);
% dataNorm=zeros(numSmp,numDim);
% 
% for j=1:numDim
%     dataNorm(:,j)=(data_train(:,j)-min(data_train(:,j)))/range(data_train(:,j));
% end

CenterVec = rand(nNeuron,nDimen); % (0,1) 20*33
[o(:,1),o(:,2)] = ind2sub([nSomRow,nSomCol],1:nNeuron);%???????????

sigma0 = 1; eta0 = 0.1; % neighborhood width & learning rate initial

for iteration = 1:iteraMax
    for n = 1:nSample
        dataCur = dataNorm(n,:); %get n'th row for each to put in SOMTrain
        SOMTrain(CenterVec, o, dataCur, eta0, sigma0, iteration, iteraMax);
    end
end

clusterId = zeros(nSample,1);
for i  =1:nSample
    clusterId(i) = SOMCompete(dataNorm(i,:), CenterVec);
end