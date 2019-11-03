function map = defect_edge_detection(im, kov_nscale, kov_norient, kov_min_wl, kov_mult, hyst_tl, hyst_th)
% DEFECT_EDGE_DETECTION Edge detection stage based on Kovesi algorithm 
%   and hysteretic thresholding.
%
%   map = defect_edge_detection(im, kov_nscale, kov_norient, kov_min_wl, kov_mult, hyst_tl, hyst_th)
%   Returns the map with the detected edges.
%   
%   * im: the image to perform the edge detection on.
%   DETECTION PARAMETERS
%       --- KOVESI
%   * kov_nscale: number of scale (wavelet)
%   * kov_norient: number of orientations (wavelet)
%   * kov_min_wl: wavelength smaller scale (wavelet)
%   * kov_mult: scale (wavelet)
%       --- HYSTERETIC THRESHOLDING
%   * hyst_tl: low thresholding value
%   * hyst_th: high thresholding value

    M = phasecong3(im, kov_nscale, kov_norient, kov_min_wl, kov_mult);
    M_scaled = ( M - min(min(M)) ) ./ ( max(max(M)) - min(min(M)) ) .* 255;
    
    % figure('Position', [0 400 1600 256]); colormap(gray(256)); imagesc(M_scaled); set(gca,'xtick',[],'ytick',[]);
    
    M_scaled_clean = hysthresh(M_scaled, hyst_tl, hyst_th);
    
    map = M_scaled_clean;
    map(map>0) = 1;
    
end