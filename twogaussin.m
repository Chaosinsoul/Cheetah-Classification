%In this script, we select the feature in multivariate gaussin as a classifier, by using the maximum likelihood estimation, we
get our 1-d gaussin classifer
BG = TrainsampleDCT_BG(:,:);
FG = TrainsampleDCT_FG(:,:);

mBG = zeros(1,64);
mFG = zeros(1,64);
sigmaBG = zeros(1,64);
sigmaFG = zeros(1,64);

for i=1:64
mBG(1,i) = mean(TrainsampleDCT_BG(:,i));
mFG(1,i) = mean(TrainsampleDCT_FG(:,i));
sigmaBG(1,i) = sqrt(var(TrainsampleDCT_BG(:,i)));
sigmaFG(1,i)= sqrt(var(TrainsampleDCT_FG(:,i))); 
end

num = (1:16);
figure
for j = 1:16    
xBG1 = mBG(1,j)-4*sigmaBG(1,j):1e-5:mBG(1,j)+4*sigmaBG(1,j); 
xFG1 = mFG(1,j)-4*sigmaFG(1,j):1e-5:mFG(1,j)+4*sigmaFG(1,j); 
yBG1 = pdf('normal', xBG1, mBG(1,j), sigmaBG(1,j));
yFG1 = pdf('normal', xFG1, mFG(1,j), sigmaFG(1,j));
subplot(4,4,j)
plot(xBG1, yBG1)
hold on 
plot(xFG1, yFG1, 'r')
legend
str = sprintf('index = %d', j);
title(str)
end

num = (17:32);
figure
for j = 17:32    
xBG1 = mBG(1,j)-4*sigmaBG(1,j):1e-5:mBG(1,j)+4*sigmaBG(1,j); 
xFG1 = mFG(1,j)-4*sigmaFG(1,j):1e-5:mFG(1,j)+4*sigmaFG(1,j); 
yBG1 = pdf('normal', xBG1, mBG(1,j), sigmaBG(1,j));
yFG1 = pdf('normal', xFG1, mFG(1,j), sigmaFG(1,j));
subplot(4,4,j-16)
plot(xBG1, yBG1)
hold on 
plot(xFG1, yFG1, 'r')
legend
str = sprintf('index = %d', j);
title(str)
end

num = (33:48);
figure
for j = 33:48    
xBG1 = mBG(1,j)-4*sigmaBG(1,j):1e-5:mBG(1,j)+4*sigmaBG(1,j); 
xFG1 = mFG(1,j)-4*sigmaFG(1,j):1e-5:mFG(1,j)+4*sigmaFG(1,j); 
yBG1 = pdf('normal', xBG1, mBG(1,j), sigmaBG(1,j));
yFG1 = pdf('normal', xFG1, mFG(1,j), sigmaFG(1,j));
subplot(4,4,j-32)
plot(xBG1, yBG1)
hold on 
plot(xFG1, yFG1, 'r')
legend
str = sprintf('index = %d', j);
title(str)
end

num = (49:64);
figure
for j = 49:64    
xBG1 = mBG(1,j)-4*sigmaBG(1,j):1e-5:mBG(1,j)+4*sigmaBG(1,j); 
xFG1 = mFG(1,j)-4*sigmaFG(1,j):1e-5:mFG(1,j)+4*sigmaFG(1,j); 
yBG1 = pdf('normal', xBG1, mBG(1,j), sigmaBG(1,j));
yFG1 = pdf('normal', xFG1, mFG(1,j), sigmaFG(1,j));
subplot(4,4,j-48)
plot(xBG1, yBG1)
hold on 
plot(xFG1, yFG1, 'r')
legend
str = sprintf('index = %d', j);
title(str)
end
