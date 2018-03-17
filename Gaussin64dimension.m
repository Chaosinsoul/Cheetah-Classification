%By maximum likelihood estimation, we generative 64 dimensional gaussin classifier. Then using this classifier to get the 
%accuracy of the prediction of the original cheetah image. 
%BG = TrainsampleDCT_BG(:,:);
%FG = TrainsampleDCT_FG(:,:);
BGRownum = 1053;
FGRownum = 250;
MeanBG64 = mean(TrainsampleDCT_BG(:,:));
MeanFG64 = mean(TrainsampleDCT_FG(:,:));
CovBG64 = cov(TrainsampleDCT_BG(:,:));
CovFG64 = cov(TrainsampleDCT_FG(:,:));
%mvnpdf(TrainsampleDCT_BG(1,:),MeanBG64,CovBG64);
originalimg=imread('cheetah.bmp');
%paddingimg = zeros(262,277);
paddingimg(1:255, 1:270) = originalimg(:,:);
I = double(paddingimg)/255;
[r,c]=size(originalimg);
zigzag = [0   1   5   6  14  15  27  28

2   4   7  13  16  26  29  42

3   8  12  17  25  30  41  43

9  11  18  24  31  40  44  53

10  19  23  32  39  45  52  54

20  22  33  38  46  51  55  60

21  34  37  47  50  56  59  61

35  36  48  49  57  58  62  63];
zigzag = zigzag+1;
Outputpix = zeros(r,c);
for i = 1:r-7 
        for j = 1:c-7
        Dctblock = (dct2(I(i:i+7, j:j+7)));
        tmp = zeros(8,8);
        tmp(zigzag) = Dctblock; 
        tmp = reshape(tmp,1,64);
        if mvnpdf(tmp,MeanBG64,CovBG64)*0.8081 < mvnpdf(tmp,MeanFG64,CovFG64)*0.1919
           Outputpix(i,j) = 1;
        else 
            Outputpix(i,j) = 0;
        end
        end
end
imagesc(Outputpix);
colormap(gray(255));
standard = imread('cheetah_mask.bmp');
standard = double(standard)/255;
count0 =0;
count1 =0;
count0_1=0;
count1_0=0;
for i =1:r
    for j = 1:c
        if standard(i,j)==0
            count0 = count0+1;
            if Outputpix(i,j)==1
             count1_0 = count1_0 + 1;
            end 
        else
            count1 = count1+1;
           if  Outputpix(i,j)==0
             count0_1 = count0_1 + 1;
           end
        end
    end
end
error = (count1/(count1+count0))*(count0_1/count1) + (count0/(count1+count0))*(count1_0/count0);


