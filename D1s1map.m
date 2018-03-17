%In this method we use maximum posterior estimation
load('TrainingSamplesDCT_subsets_8.mat');
D1_BG_Rownum = 300;
D1_FG_Rownum = 75;
MeanD1_BG = mean(D1_BG);
MeanD1_FG = mean(D1_FG);
CovD1_BG = (299/300)*cov(D1_BG);
CovD1_FG = (74/75)*cov(D1_FG);
load('Prior_1.mat');
load('Alpha.mat')
I = eye(64);
error_map = zeros(1,9);
sigmaD1_0 = zeros(64,64,9);
muD1_BG_n = zeros(64,1,9);
CovD1_BG_n = zeros(64,64,9);
CovD1_BG_n_  = zeros(64,64,9);
muD1_FG_n = zeros(64,1,9);
CovD1_FG_n = zeros(64,64,9);
CovD1_FG_n_  = zeros(64,64,9);
sigma00 = W0.*I;



for l=1:9
 a = alpha(1,l);
 sigmaD1_0(:,:,l)= a*sigma00;
 muD1_BG_n(:,:,l) = (300*sigmaD1_0(:,:,l)/(CovD1_BG+300*sigmaD1_0(:,:,l)))*transpose(MeanD1_BG) + (CovD1_BG/(CovD1_BG+300*sigmaD1_0(:,:,l)))*transpose(mu0_BG);
 
 muD1_FG_n(:,:,l) = (75*sigmaD1_0(:,:,l)/(CovD1_FG+75*sigmaD1_0(:,:,l)))*transpose(MeanD1_FG) + (CovD1_FG/(CovD1_FG+75*sigmaD1_0(:,:,l)))*transpose(mu0_FG);

 
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
        if log(mvnpdf(tmp, transpose(muD1_BG_n(:,:,l)), CovD1_BG)*(0.8081)) < log(mvnpdf(tmp,transpose(muD1_FG_n(:,:,l)), CovD1_FG) * (0.1919))
           Outputpix(i,j) = 1;
        else 
            Outputpix(i,j) = 0;
        end
        end
 end
%imagesc(Outputpix);
%colormap(gray(255));
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
 error_map(1,l) =  (count1/(count1+count0))*(count0_1/count1) + (count0/(count1+count0))*(count1_0/count0);
end
error(3,:) = error_map;








