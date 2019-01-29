function RBFW = RBFTrainWeight(nNeuron, CenterVec, dataNorm, lable_train, gMethod, gWidth)

dis = zeros(size(dataNorm, 1), nNeuron);
for i = 1:size(dataNorm, 1)
    xs = repmat(dataNorm(i,:), nNeuron, 1);
%     d(i,:) = EuclidDist(xs, CenterVec);
%     function d = EuclidDist(x1, x2)
% 
    d=zeros(size(xs,1),1);
    for n=1:size(xs,1)
        for j=1:size(xs,2)
            d(n)=d(n)+((xs(n,j)-CenterVec(n,j))^2);
        end
    end
    d=d.^(1/2);
    dis(i,:)=d;
end

Phi = zeros(size(dataNorm, 1),1); %PPT 6-16 ??
if gMethod == 'Gaussian'
    Phi = exp(-dis.^2./(2*gWidth^2));
end

dis = lable_train;

RBFW = inv((Phi)'*Phi)*(Phi)'*dis;