function winNEU = SOMCompete(dataCur, CenterVec)

xs = repmat(dataCur, size(CenterVec,1), 1);%copy dataCur 20row £¿
%calculate the Euclidean distance
d = zeros(size(xs,1),1);
for i = 1:size(xs,1)
    for j = 1:size(xs,2)
        d(i) = d(i)+((xs(i,j)-CenterVec(i,j))^2);
    end
end
d = d.^(1/2);

[~,winNEU] = min(d);