function [loss, acc] = segmentation_test(im, im_high, ... % image to test (with/withot highlight)
                                         encoded_correct_pixels, ... % actual regions
                                         kov_nscale, kov_norient, kov_min_wl, kov_mult, ... %kovesi
                                         hist_tl, hist_th, ... % hysteretic edge follower
                                         alpha, hole_th, region_th) % alpha shape

    map = defect_edge_detection(im, kov_nscale, kov_norient, kov_min_wl, kov_mult, hist_tl, hist_th);
    
    map(1:end,1) = 1;
    map(1,1:end) = 1;
    map(end, 1:end) = 1;
    map(1:end, end) = 1;

    [number_of_regions, encoded_shape_maps, bounding_boxes, shp] = segmentate_image(map, alpha, hole_th, region_th);

    im_size = size(im);
    output1 = zeros(im_size);
    output2 = zeros(im_size);
    output1_binary = zeros(im_size);
    output2_binary = zeros(im_size);
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
    
    output1_binary(output1>0) = 1;
    output2_binary(output2>0) = 1;
    
    encoded_proposed_pixels = rle_encoding(output2_binary);
    
    % scores
    loss = 1 - loss_function(encoded_proposed_pixels, encoded_correct_pixels, im_size);
    acc = accuracy_segmentation(encoded_proposed_pixels, encoded_correct_pixels, im_size);

    figure('Position', [0 500 1600 256]); imshow(map,'InitialMagnification','fit');
    figure('Position', [0 500 1600 256]); imshow(im_high,'InitialMagnification','fit');
    figure('Position', [0 100 1600 256]); imagesc(output1); % segmented
    figure('Position', [0 100 1600 256]); imagesc(output2); % bounding box
    
    % debug plots
    % [~, map_corrected] = rle_decoding(encoded_correct_pixels, im_size);
    % figure('Position', [0 500 1600 256]); imshow(map_corrected,'InitialMagnification','fit');
    % figure('Position', [0 500 1600 256]); imshow(output2_binary,'InitialMagnification','fit');
    
end
    