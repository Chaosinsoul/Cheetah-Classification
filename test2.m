load('TrainingSamplesDCT_8_new.mat')
%%define parameter for initialization 
X = TrainsampleDCT_BG;
Y = TrainsampleDCT_FG;
C=[1,2,4,8,16,32];
max_iters = 1000;


[muX,sigmaX,piX] = EM_parameter(X,C(6), max_iters );
[muY,sigmaY,piY] = EM_parameter(Y,C(6), max_iters );

originalimg=imread('cheetah.bmp');
%paddingimg = zeros(262,277);
paddingimg(1:255, 1:270) = originalimg(:,:);
I = double(paddingimg)/255;
%[r,c]=size(originalimg);
zigzag = [0   1   5   6  14  15  27  28

2   4   7  13  16  26  29  42

3   8  12  17  25  30  41  43

9  11  18  24  31  40  44  53

10  19  23  32  39  45  52  54

20  22  33  38  46  51  55  60

21  34  37  47  50  56  59  61

35  36  48  49  57  58  62  63];
zigzag = zigzag+1;
Outputpix = zeros(255,270,11,5);
Dimension = [1,2,4,8,16,24,32,40,48,56,64];
error = zeros(5,11);
for i = 1:255-7 
        for j = 1:270-7
        Dctblock = (dct2(I(i:i+7, j:j+7)));
        tmp = zeros(8,8);
        tmp(zigzag) = Dctblock; 
        tmp = reshape(tmp,1,64);
        
         for k = 1:11
           if probcompare(tmp(1:Dimension(k)),muX(:,1:Dimension(k)),sigmaX(1:Dimension(k),1:Dimension(k),:),piX)*0.8081 < probcompare(tmp(1:Dimension(k)),muY(:,1:Dimension(k)),sigmaY(1:Dimension(k),1:Dimension(k),:),piY)*0.1919
              Outputpix(i,j,k) = 1;
           else 
              Outputpix(i,j,k) = 0;
           end
         end
        end
        
end
%imagesc(Outputpix);
%colormap(gray(255));
standard = imread('cheetah_mask.bmp');
standard = double(standard)/255;

 for k = 1:11
 count0 =0;
 count1 =0;
 count0_1=0;
 count1_0=0;
  for i =1:255
    for j = 1:270
        if standard(i,j)==0
            count0 = count0+1;
            if Outputpix(i,j,k)==1
             count1_0 = count1_0 + 1;
            end 
        else
            count1 = count1+1;
           if  Outputpix(i,j,k)==0
             count0_1 = count0_1 + 1;
           end
        end
    end
  end
  error6(1,k) = (count1/(count1+count0))*(count0_1/count1) + (count0/(count1+count0))*(count1_0/count0);
 end

%em_plot(error,11)
