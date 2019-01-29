function [output, RBFValu] = RBFTest(CenterVec, RBFW, data_test, gWidth)

d = zeros(size(data_test, 1), size(CenterVec, 1));
for i = 1:size(data_test, 1)
    xs = repmat(data_test(i,:), size(CenterVec,1), 1);
    d(i,:) = EuclidDist(xs,CenterVec);
end

Phi = exp(-d.^2./(2*gWidth^2));

RBFValu = Phi*RBFW;
output = Phi;