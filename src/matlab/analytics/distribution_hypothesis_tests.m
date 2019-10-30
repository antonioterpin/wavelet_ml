function [results] = distribution_hypoteses_test(x, h_th)
%DISTRIBUTION_HYPOTESES_TEST Perform some distribution hypothesis tests
%
%   results = DISTRIBUTION_HYPOTESES_TEST(x)
%   The p value threshold is by default 0.001
%   results = [ 
%       distribution name      p value      h0 rejected
%   ];    
%
%   results = DISTRIBUTION_HYPOTESES_TEST(x, h_th)
%   Perform hypothesis tests with threshold h_th
%

    if nargin < 2
        h_th = 0.001;
    end

% "Binomial"
% "Burr"
    distributions = [
            "BirnbaumSaunders"
            "Exponential"
            "ExtremeValue"
            "Gamma"
            "GeneralizedExtremeValue"
            "GeneralizedPareto"
            "HalfNormal"
            "InverseGaussian"
            "Kernel"
            "Logistic"
            "Loglogistic"
            "Lognormal"
            "Nakagami"
            "NegativeBinomial"
            "Normal"
            "Poisson"
            "Rayleigh"
            "Rician"
            "Stable"
            "tLocationScale"
            "Weibull"
        ];
    
    ph_results = string(zeros(size(distributions,2), 2));
    bool_str = ["False" "True"];
    
    for i = 1:size(distributions)
        pd = fitdist(x, distributions(i));
        [h, p] = chi2gof(x, "cdf", pd);
        ph_results(i,:) = [sprintf('%0.5e',p) bool_str(1 + (p < h_th))];
    end
    
    results = table(distributions, ph_results(:,1), ph_results(:,2), 'VariableNames', {'Distribution', 'pValue', 'h'});

end

