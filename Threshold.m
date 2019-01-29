function rlt  = Threshold(RBFValu, threshold)

for i = 1:size(RBFValu, 1)
    if RBFValu(i) > threshold
        rlt(i) = 1;
    else
        rlt(i) = -1;
    end
end

rlt = rlt';