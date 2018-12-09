function mu = softmax2(eta,c)
    % Softmax function
    % mu(i,c) = exp(eta(i,c))/sum_c' exp(eta(i,c'))

    % This file is from matlabtools.googlecode.com
     
    eta = 1 ./ eta; 
        
    tmp = exp(c*eta);
    denom = sum(tmp, 2);
    mu = bsxfun(@rdivide, tmp, denom);

end
