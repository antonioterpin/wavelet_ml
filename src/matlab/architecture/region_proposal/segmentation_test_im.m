function [loss, acc] = segmentation_test_im(im, ... % image to test
                                            encoded_correct_pixels, ... % defect regions (RLE)
                                            params, ... % struct with segmentation parameters
                                            plot_flag, im_high) % optional (for plots)
% SEGMENTATION_TEST_IM Calculates loss and accuracy on given image (im).                                      
%
%   [loss, acc] = segmentation_test_im(im, encoded_correct_pixels, params) 
%   calculates segmentation loss and accuracy on given image im with 
%   segmentation parameters params.
%  
%   [_] = segmentation_test_im(_, plot_flag) also plots the segmentation
%   results.
%
%   [_] = segmentation_test_im(_, im_high) also plots the image with
%   highlighted defects for comparison (im_high).
% 
%   PARAMETERS:
%       --- KOVESI
%   * params.kov_nscale   
%   * params.kov_norient
%   * params.kov_min_wl
%   * params.kov_mult
%       --- HYSTERETIC EDGE DETECTOR
%   * params.hist_tl      
%   * params.hist_th
%       --- ALPHA SHAPE
%   * params.alpha        
%   * params.hole_th
%   * params.region_th
                                        
    if nargin == 3
        plot_flag = 0;
        plot_high = 0;
        
    elseif nargin == 4
        plot_high = 0;
        
    elseif nargin == 5
        plot_high = 1;
        
    end 
                                            
    map = defect_edge_detection(im, ...
                                params.kov_nscale, ...
                                params.kov_norient, ...
                                params.kov_min_wl, ...
                                params.kov_mult, ...
                                params.hist_tl, ...
                                params.hist_th);
    
    map(1:end,1) = 1;
    map(1,1:end) = 1;
    map(end, 1:end) = 1;
    map(1:end, end) = 1;

    [number_of_regions, encoded_shape_maps, bounding_boxes, shp] = segmentate_image(map, ...
                                                                                    params.alpha, ...
                                                                                    params.hole_th, ...
                                                                                    params.region_th);

    im_size = size(im);
    output1 = zeros(im_size);
    output2 = zeros(im_size);
    x = 1:im_size(2); y = 1:im_size(1); [X,Y] = meshgrid(x,y);

    for region_id = 1:number_of_regions
        color = floor(255 / number_of_regions) * region_id;
    
        % predicted regions
        filled_shape_feature = zeros(im_size(1)*im_size(2),1);
        filled_shape_feature(inShape(shp,X(:),Y(:),region_id)) = color;
        filled_shape_feature = reshape(filled_shape_feature, im_size(1), im_size(2));
        output1 = output1 + filled_shape_feature;
        
        % debug
        % sprintf("%d-%d, %d-%d",bounding_boxes(1,1,region_id),bounding_boxes(1,2,region_id), ...
        %    bounding_boxes(2,1,region_id),bounding_boxes(2,2,region_id))
    
        % predicted bounding box
        output2(bounding_boxes(1,2,region_id):bounding_boxes(2,2,region_id), ...
            bounding_boxes(1,1,region_id):bounding_boxes(2,1,region_id)) = color;
    end
    
    proposed_pixels = zeros(im_size);
    proposed_pixels(output2>0) = 1;
    
    encoded_proposed_pixels = rle_encoding(proposed_pixels);
    
    % scores
    loss = 1 - loss_function(encoded_proposed_pixels, encoded_correct_pixels, im_size);
    acc = accuracy_segmentation(encoded_proposed_pixels, encoded_correct_pixels, im_size);

    if plot_flag
        
        figure('Position', [0 400 1600 256]); imshow(im,'InitialMagnification','fit');
        
        if plot_high
            figure('Position', [0 400 1600 256]); imshow(im_high,'InitialMagnification','fit');
        end
        
        figure('Position', [0 400 1600 256]); imshow(map,'InitialMagnification','fit');
        figure('Position', [0 50 1600 256]); imagesc(output1); % segmented
        figure('Position', [0 50 1600 256]); imagesc(output2); % bounding box
        
    end
    
    % debug plots
    % [~, map_corrected] = rle_decoding(encoded_correct_pixels, im_size);
    % figure('Position', [0 500 1600 256]); imshow(map_corrected,'InitialMagnification','fit');
    % figure('Position', [0 500 1600 256]); imshow(output2_binary,'InitialMagnification','fit');
    
end
    