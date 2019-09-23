function filtered_image = m_edge_detection(image, gauss_blur_sigma, threshold, sigma)
    % M_EDGE_DETECTION parametric edge detection algorithm.
    %
    % gauss_blur_sigma: sigma for the gaussian filter
    
    % 1. Gaussian filter to remove noise
    smoothed_image = imgaussfilt(image, gauss_blur_sigma);
    
    % 2. Canny filter
    filtered_image = edge(smoothed_image,"Canny", threshold, sigma) * 255;
end