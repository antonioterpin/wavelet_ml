function [results] = distribution_hypoteses_test(x, h_th)
%DISTRIBUTION_HYPOTESES_TEST Perform some hypoteses tests on x and return
%results
%   results = DISTRIBUTION_HYPOTESES_TEST(x)
%   results = [ 
%       normal_mu   normal_sigma    p_value     h;
%       logn_mu     logn_sigma      p_vale      h;
%       weibull_a   weibull_b       p_vale      h;
%       gamma_a     gamma_b         p_vale      h;
%   ];    

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
        ph_results(i,:) = [sprintf('%0.5e',p) bool_str(1 + (p > h_th))];
    end
    
    results = table(distributions, ph_results(:,1), ph_results(:,2), 'VariableNames', {'Distribution', 'pValue', 'h'});

end

