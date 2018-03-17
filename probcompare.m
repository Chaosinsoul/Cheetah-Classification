function [ probX ] = probcompare(xi, mu_, sigma, pi )
    probX = 0; 
    for i = 1:size(mu_,1)
     probX = probX  + mvnpdf(xi,mu_(i,:),sigma(:,:,i))*pi(1,i);
    end
end



