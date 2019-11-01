function map = defect_edge_detection(im, kov_nscale, kov_norient, kov_min_wl, kov_mult, hyst_tl, hyst_th)

    M = phasecong3(im, kov_nscale, kov_norient, kov_min_wl, kov_mult);
    M_scaled = ( M - min(min(M)) ) ./ ( max(max(M)) - min(min(M)) ) .* 255;
    
    % figure('Position', [0 400 1600 256]); colormap(gray(256)); imagesc(M_scaled); set(gca,'xtick',[],'ytick',[]);
    
    M_scaled_clean = hysthresh(M_scaled, hyst_tl, hyst_th);
    
    map = M_scaled_clean;
    map(map>0) = 1;
    
end