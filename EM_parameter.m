function [mu_,sigma,pi] = EM_parameter(X,k, max_iters )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

%%define parameter for initialization 
n = size(X,1); % number of data point 
d = size(X,2); % dimension of data point 
%k = 8; %number of cluster 
eps = 0.0000000001; %threshold to stop iteration 
pi = zeros(1,k); 
pi(1,:) = 1/k;  % weight for every cluster 
r = randi([1 n],1,k); % random number for mu initianization 
mu_ = X(r(:),:); 
%mu = mu_';  % randomly initianize the mu by arbitrary data points in data set:   dimension  64*8
sigma = zeros(d,d,k);
for i =1:k 
 alpha = 20+10*rand(1,d);
 I = eye(d);
 sigma(:,:,i) = alpha.*I;
end          % initianize sigma 
W = zeros(n,k); % hij, weighted prab
R = zeros(n,k); % for calculation 
log_likelihoods = zeros(1,max_iters ); % for the purpose of checking convergence
%max_iters = 130;  % maximum number of iteration


%for it = 1:max_iters
for it = 1:max_iters
    %% E step 
    for i = 1:k
       R(:,i) =  pi(i)*mvnpdf(X,mu_(i,:),sigma(:,:,i));  % 1053*8           
    end
  log_likelihoods(1,it) =  sum(log(sum(R,2)));   
   % normalize R to get W 
   W = R./sum(R,2);
 
   %% M step 
   pi = sum(W,1)./n;
   mu_ = (W'*X)./sum(W,1)';
   for j = 1:k
    sigma_sub = (X-mu_(j,:))'.*W(:,j)'*(X-mu_(j,:));
    sigma(:,:,j)  = diag(diag((sigma_sub./sum(W(:,j),1))+0.0000001));
   end
   
   if it<2
    continue;
   end
   if abs(log_likelihoods(1,it) - log_likelihoods(1,it-1))<eps
       break; 
   end
end  

%plot(1:it,log_likelihoods(1:it))    
end

