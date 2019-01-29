function CenterVec = SOMTrain(CenterVec, o, dataCur, eta0, sigma0, iteration, iteraMax)

winNEU = SOMCompete(dataCur, CenterVec);

tao1 = iteraMax;
tao2 = iteraMax/log10(sigma0);%PPT 5.21

etaN = eta0*exp(-iteration/tao2);%PPT 5.19
sigmaN = sigma0*exp(-iteration/tao1);%PPT 5.14

for i = 1:size(CenterVec,1) %size of row(330)
    h = exp(-sum((o(i,:)-o(winNEU,:)).^2)/(2*sigmaN^2)); %PPT 5-15
    CenterVec(i,:) = CenterVec(i,:)+etaN*h*(dataCur-CenterVec(i,:)); %PPT 5-24
end