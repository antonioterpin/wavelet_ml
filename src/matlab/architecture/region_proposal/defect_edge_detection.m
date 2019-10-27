function map = defect_edge_detection(im, nscale, norient, minWaveLength, mult, tl, th)
% function map = defect_edge_detection(im,tl,th)

    M = phasecong3(im, nscale, norient, minWaveLength, mult);
    M_scaled = ( M - min(min(M)) ) ./ ( max(max(M)) - min(min(M)) ) .* 255;
    
    % figure; imshow(M);
    
    M_scaled_clean = hysthresh(M_scaled,tl,th);
    
    map = M_scaled_clean;
    map(map>0) = 1;
    
end