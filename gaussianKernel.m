function sim = gaussianKernel(x1, x2, sigma)
%	This function returns a radial basis function (RBF) kernel between
%	x1 and x2 computed using a Gaussian kernel with bandwidth sigma

% Ensure that x1 and x2 are column vectors
x1 = x1(:); x2 = x2(:);

sim = exp(-sum((x1 - x2) .* (x1 - x2)) / (2 * sigma * sigma));
    
end
