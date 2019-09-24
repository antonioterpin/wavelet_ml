function [distribution_map,mu,sigma] = map2distribution_map(rle_encoded_defects, image_size)
%MAP2PROBABILISTIC_MAP Returns the relative frequencies distribution for
% the given defective pixels and their bivariate gaussian distribution parameters.
%   
%   [distribution_map,mu,sigma] = map2distribution_map(rle_encoded_defects, image_size)
    
    distribution_map = zeros(image_size); % initialize to zero all frequencies
    total_number_of_defects = 0;
    
    % Remark: since it is not possible with cum sum ecc. to identify wheter
    % a point is inside the alpha shape region, the following is done to
    % optimize
    x = 1:image_size(2); y = 1:image_size(1); [X,Y] = meshgrid(x,y);
    
    for i = 1 : size(rle_encoded_defects)
        % 1. get regions
        [~,map] = rle_decoding(rle_encoded_defects(i), image_size);
        [number_of_regions, ~, bounding_boxes,shp] = segmentate_image(map);
        for region_id = 1 : number_of_regions
            % 2. get shape feature
            filled_shape_feature = zeros(image_size(2)*image_size(1),1);
            filled_shape_feature(inShape(shp,X(:),Y(:)),region_id) = 1;
            filled_shape_feature = reshape(filled_shape_feature, image_size(1), image_size(2));
            % unwrap bounding box
            minX = bounding_boxes(1,1,region_id); minY = bounding_boxes(1,2,region_id);
            maxX = bounding_boxes(2,1,region_id); maxY = bounding_boxes(2,2,region_id);
            displacement_vector = floor([image_size(2) image_size(1)] / 2) - floor(([maxX - minX maxY - minY]) / 2);
            % 3. increment frequencies
            boundsx = displacement_vector(1):displacement_vector(1) + maxX - minX;
            boundsy = displacement_vector(2):displacement_vector(2) + maxY - minY;
            distribution_map(boundsy, boundsx) = distribution_map(boundsy, boundsx) + filled_shape_feature(minY:maxY,minX:maxX);
            % 4. TODO bivariate gaussian distribution
        end
        % 5. increment total number of defects
        total_number_of_defects = total_number_of_defects + number_of_regions;
    end
    
    % 6. normalize frequencies
    distribution_map = distribution_map / total_number_of_defects;

end

