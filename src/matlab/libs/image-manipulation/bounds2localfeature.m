function [shape_feature,local_feature] = bounds2localfeature(encoded_shape_feature,bounding_box,image)
%ALPHA_SHAPE Given the region bounds returns both shape and local
%features.
%   [shape_feature,local_feature] = bounds2localfeature(encoded_shape_feature,bounding_box,image)
% See also SEGMENTATE_IMAGE, ALPHA_SHAPE

    image_size = size(image);
    shape_feature = zeros(image_size); local_feature = zeros(image_size); % black image
    [~,decoded_displaced_shape_feature] = rle_decoding(encoded_shape_feature,image_size);
    % center bounds
    % unwrap bounding box
    minX = bounding_box(1,1); minY = bounding_box(1,2);
    maxX = bounding_box(2,1); maxY = bounding_box(2,2);
    displacement_vector = floor([image_size(2) image_size(1)] / 2)...
        - floor(([maxX - minX maxY - minY]) / 2);
    shape_feature(displacement_vector(2):displacement_vector(2) + maxY - minY,...
        displacement_vector(1):displacement_vector(1) + maxX - minX) = ...
        decoded_displaced_shape_feature(minY:maxY,minX:maxX);
    if image_size(1) >= maxY && image_size(2) >= maxX
        local_feature(displacement_vector(2):displacement_vector(2) + maxY - minY,...
            displacement_vector(1):displacement_vector(1) + maxX - minX) = ...
            image(minY:maxY,minX:maxX);
    end
end
